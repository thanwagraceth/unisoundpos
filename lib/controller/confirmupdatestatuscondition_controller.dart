import 'package:unisoundpos/api/updatestatusconditionbyskuth.dart';

Future<bool> confirmupdatestatusconditionController(
    List<String> listskuth, String tostatus, String tocondition) async {
  List<String> listtostatus = [];
  List<String> listtoconditions = [];
  for (String element in listskuth) {
    listtostatus.add(tostatus);
    listtoconditions.add(tocondition);
  }
  bool result = await updatestatusconditionbyskuth(listskuth.toString(),
      listtostatus.toString(), listtoconditions.toString());
  return result;
}
