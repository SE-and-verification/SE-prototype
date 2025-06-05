import re


def parse_module_file(input_file):
    """Parses the input file to extract module names, inputs, outputs, and buffer depth."""
    modules = []
    with open(input_file, "r") as f:
        content = f.read()
    module_blocks = content.strip().split("\n\n")  # Split blocks by double newline

    for block in module_blocks:
        lines = block.splitlines()
        module_name = lines[0].strip()
        depth_match = re.search(r"depth:\s*(\d+)", block)
        inputs_line = re.search(r"inputs:\s*(.*)", block)
        outputs_line = re.search(r"outputs:\s*(.*)", block)

        depth = int(depth_match.group(1)) if depth_match else 1
        inputs = parse_signals(inputs_line.group(1)) if inputs_line else []
        outputs = parse_signals(outputs_line.group(1)) if outputs_line else []

        modules.append(
            {"name": module_name, "inputs": inputs, "outputs": outputs, "depth": depth}
        )
    return modules


def parse_signals(signal_line):
    """Parses signal declarations into a list of dictionaries."""
    signals = []
    for sig in signal_line.split(","):
        match = re.match(r"(\w+)(\[(\d+)\])?", sig.strip())
        if match:
            name = match.group(1)
            width = int(match.group(3)) if match.group(3) else 1  # Default width is 1
            signals.append({"name": name, "width": width})
    return signals


def generate_verilog(modules, output_file):
    """Generates Verilog code for buffering module outputs."""
    with open(output_file, "w") as f:
        f.write("// Auto-generated Verilog file\n\n")
        for module in modules:
            module_name = module["name"]
            outputs = module["outputs"]
            depth = module["depth"]

            f.write(f"module {module_name}_buffer (\n")
            f.write("    input clk,\n")
            f.write("    input write_en,\n")
            for output in outputs:
                sig_name = output["name"]
                sig_width = f"[{output['width'] - 1}:0] " if output["width"] > 1 else ""
                f.write(f"    input {sig_width}{sig_name},\n")
                f.write(f"    output {sig_width}{sig_name}_buffered,\n")
            f.write(");\n\n")

            for output in outputs:
                sig_name = output["name"]
                sig_width = f"[{output['width'] - 1}:0] " if output["width"] > 1 else ""
                f.write(f"    reg {sig_width}{sig_name}_buffered;\n")
                f.write(f"    reg {sig_width} {sig_name}_mem [0:{depth - 1}];\n")
            f.write(f"    reg [$clog2({depth})-1:0] write_ptr = 0;\n\n")

            f.write("    always @(posedge clk) begin\n")
            f.write("        if (write_en) begin\n")
            for output in outputs:
                sig_name = output["name"]
                f.write(f"            {sig_name}_mem[write_ptr] <= {sig_name};\n")
            f.write("            write_ptr <= write_ptr + 1;\n")
            f.write("        end\n")
            f.write("    end\n\n")

            for output in outputs:
                sig_name = output["name"]
                f.write(
                    f"    assign {sig_name}_buffered = {sig_name}_mem[write_ptr];\n"
                )

            f.write("endmodule\n\n")


def main():
    input_file = "assertions/modules.txt"  # Replace with your input file name
    output_file = (
        "assertions/buffered_modules.v"  # Replace with your desired output file name
    )

    modules = parse_module_file(input_file)
    generate_verilog(modules, output_file)
    print(f"Verilog file generated: {output_file}")


if __name__ == "__main__":
    main()
