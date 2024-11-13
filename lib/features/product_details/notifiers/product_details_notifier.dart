import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/product_details_repository.dart';
import 'app_state.dart';

class ProductDetailsListFetchNotifier extends StateNotifier<AppState> {
  ProductDetailsRepository productDetailsRepository;
  ProductDetailsListFetchNotifier(this.productDetailsRepository)
      : super(const AppState.initial());

  fetchProductDetails(String productName) async {
    state = const AppState.loading();
    final either = await productDetailsRepository
        .getProductDetails(productName);

    state = either.fold(
          (l) => AppState.failure(l),
          (r) => AppState.success(r),
    );
  }
}

final productDetailsListFetchNotifierProvider =
StateNotifierProvider<ProductDetailsListFetchNotifier, AppState>(
        (ref) => ProductDetailsListFetchNotifier(
        ref.read(productDetailsRepositoryProvider)));
