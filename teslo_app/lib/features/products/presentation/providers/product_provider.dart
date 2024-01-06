import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductNotifier(
      productsRepository: productsRepository, productId: productId);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  ProductNotifier({required this.productsRepository, required productId})
      : super(ProductState(id: productId)) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'kid',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 1));
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }
      final product = await productsRepository.getProductById(state.id);
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      print(e);
    }
    //   if (state.isLoading || state.isLastPage) return;

    //   state = state.copyWith(isLoading: true);

    //   final products = await productsRepository.getProductsByPage(
    //       limit: state.limit, offset: state.offset);

    //   if (products.isEmpty) {
    //     state = state.copyWith(isLoading: false, isLastPage: true);
    //     return;
    //   }

    //   state = state.copyWith(
    //       isLastPage: false,
    //       isLoading: false,
    //       offset: state.offset + 10,
    //       products: [...state.products, ...products]);
  }
}

class ProductState {
  final String id;
  final bool isLoading;
  final bool isSaving;
  final Product? product;

  ProductState(
      {required this.id,
      this.isLoading = false,
      this.isSaving = false,
      this.product});

  ProductState copyWith(
          {String? id, bool? isLoading, bool? isSaving, Product? product}) =>
      ProductState(
        id: id ?? this.id,
        isSaving: isSaving ?? this.isSaving,
        isLoading: isLoading ?? this.isLoading,
        product: product ?? this.product,
      );
}
