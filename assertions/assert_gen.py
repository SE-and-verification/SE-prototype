import csv
import argparse
import re

clock = "clock"
reset = "reset"


# This function interprets the CSV file and collect the signal mapping and instance signal information
def parseMapping(mapfile):
    with open(mapfile, newline="") as csvfile:
        mapreader = csv.reader(csvfile, delimiter=" ", quotechar="|")
        module_name = "IO"
        rtl_instance_name = "SE"
        signal_map = dict()
        instance_signals = dict()
        output_buffer_map = dict()
        for row in mapreader:
            if len(row) > 1:
                continue
            row = row[0].split(",")
            if len(row[0]) != 0:
                module_name = row[0]
                # if len(row[2]) == 0:
                #     continue
                rtl_instance_name = row[2]
            if len(row[3]) == 0 or len(row[4]) == 0:
                continue
            if rtl_instance_name not in instance_signals.keys():
                instance_signals[rtl_instance_name] = [row[4]]
            else:
                instance_signals[rtl_instance_name].append(row[4])
            if rtl_instance_name == "SE" or rtl_instance_name == "":
                signal_map[module_name + "." + row[3]] = row[4]
            else:
                signal_map[module_name + "." + row[3]] = (
                    rtl_instance_name + "." + row[4]
                )
            if (row[5] == "Input" and module_name == "IO") or (
                row[5] == "Output" and module_name != "IO"
            ):
                if row[4].find("[") >= 0:
                    index = row[4].find("[")
                    buffer_name = row[4][:index] + "_buffer" + row[4][index:]
                else:
                    buffer_name = row[4] + "_buffer"
                if rtl_instance_name == "SE" or rtl_instance_name == "":
                    output_buffer_map[row[4]] = buffer_name
                else:
                    output_buffer_map[rtl_instance_name + "." + row[4]] = (
                        rtl_instance_name.replace(".", "_") + "_" + buffer_name
                    )
        # for signal in output_buffer_map.keys():
        #     print(signal, output_buffer_map[signal])
        return signal_map, instance_signals, output_buffer_map


# This function outputs the connection assertions into the output file
def assertGen(signal_map, output_buffer_map, connectionfile, outputfile):
    assertion_list = []
    with open(connectionfile, "r") as csvfile:
        connectionreader = csv.reader(csvfile, delimiter=",", quotechar="|")
        for row in connectionreader:
            if row[0] == "From Signal":
                continue
            from_signal_isa = row[0]
            to_signal_isa = row[1]
            from_signal_rtl = signal_map[from_signal_isa]
            to_signal_rtl = signal_map[to_signal_isa]
            from_instance_rtl = from_signal_rtl[: from_signal_rtl.rfind(".")]
            to_instance_rtl = to_signal_rtl[: to_signal_rtl.rfind(".")]
            condition = row[2].replace("inst_reg", signal_map["inst_reg"])
            print(condition)
            from_signal_field = ""
            if from_signal.find("[") >= 0:
                from_signal_field = from_signal[from_signal.find("[") :]
                from_signal = from_signal[: from_signal.find("[")]
            assertion = (
                "assert property -name " + from_signal + "_to_" + to_signal + " {"
            )
            assertion += "\n\t@(posedge " + clock + ") disable iff (!" + reset + ")"


if __name__ == "__main__":
    parse = argparse.ArgumentParser()
    parse.add_argument(
        "--mapping",
        dest="mapfile",
        default="SE_Integrity_Spec - signal_mapping.csv",
        help="SE Signal Mapping CSV File",
    )

    parse.add_argument(
        "--connection",
        dest="connectionfile",
        default="SE_Integrity_Spec - connection_spec.csv",
        help="SE Signal Connection CSV File",
    )

    parse.add_argument(
        "--output",
        dest="outputfile",
        default="SE_assertion.tcl",
        help="Output Assertion Tcl File",
    )
    args = parse.parse_args()

    signal_map, instance_signals, output_buffer_map = parseMapping(args.mapfile)

    # print(output_buffer_map)

    assertGen(signal_map, output_buffer_map, args.connectionfile, args.outputfile)
