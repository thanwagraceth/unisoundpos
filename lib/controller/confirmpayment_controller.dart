import 'package:unisoundpos/api/salesreporteucild.dart';
import 'package:unisoundpos/model/paymentdetail_model.dart';

Future<bool> confirmpaymentController(PaymentdetailModel setpayment) async {
  bool result = await salesreporteucild(setpayment);
  return result;
}
