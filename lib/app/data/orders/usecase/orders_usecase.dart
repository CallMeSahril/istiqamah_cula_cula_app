import 'package:dartz/dartz.dart';
import 'package:istiqamah_cula_cula_app/app/core/errors/failure.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/payment_method.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/remote/orders_remote_datasource.dart';

class CreateOrderUsecase {
  final OrdersRemoteDatasource datasource = OrdersRemoteDatasource();

  Future<Either<Failure, dynamic>> call(Map<String, dynamic> body) =>
      datasource.createOrder(body);
}

class GetOrdersByStatusUsecase {
  final OrdersRemoteDatasource datasource = OrdersRemoteDatasource();

  Future<Either<Failure, List<OrderEntities>>> call(String status) =>
      datasource.getOrdersByStatus(status);
}

class GetPaymentMethodsUsecase {
  final OrdersRemoteDatasource datasource = OrdersRemoteDatasource();

  Future<Either<Failure, List<PaymentMethod>>> call(int amount) =>
      datasource.getPaymentMethods(amount);
}

class CheckPaymentStatusUsecase {
  final OrdersRemoteDatasource datasource = OrdersRemoteDatasource();

  Future<Either<Failure, bool>> call(String merchantOrderId) =>
      datasource.checkPaymentStatus(merchantOrderId);
}
