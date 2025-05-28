import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/api_helper/api_helper.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/payment_method.dart';

class OrdersRemoteDatasource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, dynamic>> createOrder(Map<String, dynamic> body) async {
    try {
      final response = await apiHelper.post('/orders', data: body);
      print(response.data['meta']['message']['paymentUrl']);
      return Right(response.data['meta']['message']['paymentUrl']);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<OrderEntities>>> getOrdersByStatus(
      String status) async {
    try {
      final response = await apiHelper.get('/orders/$status');
      final data = response.data['data'] as List;
      final result = data.map((e) => OrderEntities.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods(
      int amount) async {
    try {
      final response = await apiHelper.post('/duitku/get-payment', data: {
        'paymentAmount': amount,
      });
      final data = response.data['data']['paymentFee'] as List;
      final result = data.map((e) => PaymentMethod.fromJson(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> checkPaymentStatus(
      String merchantOrderId) async {
    try {
      final response = await apiHelper.post('/check-payment', data: {
        'merchant_order_id': merchantOrderId,
      });
      return Right(response.data['isSuccess'] == true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
