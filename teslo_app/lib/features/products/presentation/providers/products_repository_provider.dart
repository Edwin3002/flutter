import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/products_repository.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final token = ref.watch(authProvider).user?.token ?? "";

  final productsRepository =
      ProductsRepositoryImpl(ProductsDatasourceImpl(accessToken: token));

  return productsRepository;
});
