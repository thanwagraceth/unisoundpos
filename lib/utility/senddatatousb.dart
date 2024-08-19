import 'package:serial_port_win32/serial_port_win32.dart';

sendcommandopendrawer() {
  //final ports = SerialPort.getAvailablePorts();
  //print(ports);
  /// result like [COM3, COM4]
  final List<PortInfo> ports = SerialPort.getPortsWithFullMessages();
  for (PortInfo element in ports) {
    if (element.friendlyName.split(" ")[0] == "Prolific") {
      final port = SerialPort(element.portName,
          openNow: false,
          ByteSize: 8,
          ReadIntervalTimeout: 1,
          ReadTotalTimeoutConstant: 2);
      port.open();
      String buffer = "opendrawer";
      port.writeBytesFromString(buffer);
      port.close();
    }
  }
}
