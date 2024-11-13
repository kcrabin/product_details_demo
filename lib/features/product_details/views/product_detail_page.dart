import 'package:auto_route/auto_route.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_details/features/product_details/data/model/product_details_model.dart';

import '../../../core/views/base_widget.dart';
import '../notifiers/product_details_notifier.dart';
import 'widgets/add_to_cart_section.dart';
import 'widgets/message_seller_section.dart';
import 'widgets/product_description_and_specification_section.dart';
import 'widgets/product_image_section.dart';
import 'widgets/product_info_section.dart';
import 'widgets/review_section.dart';
import 'widgets/variant_selector.dart';

@RoutePage()
class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HookBaseWidget(builder: (context, config, theme) {
      useEffect(() {
        Future.microtask(() {
          ref
              .read(productDetailsListFetchNotifierProvider.notifier)
              .fetchProductDetails('realme-c30');
        });
      }, []);

      //
      final productDetailsFetchState =
          ref.watch(productDetailsListFetchNotifierProvider);

      final selectedVariant = useState<VariantDetail?>(null);

      return FloatingDraggableWidget(mainScreenWidget: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Product Details"),
          ),
          body: productDetailsFetchState.map(
            initial: (value) => const Text(''),
            loading: (value) => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (value) {
              final Product productDetails = value.data;
              selectedVariant.value ??= productDetails.variantDetails.isNotEmpty
                  ? productDetails.variantDetails.first
                  : VariantDetail(
                id: productDetails.id,
                price: productDetails.price,
                strikePrice: productDetails.strikePrice,
                minOrder: productDetails.minOrder,
                maxOrder: productDetails.maxOrder,
                status: productDetails.status,
                stock: productDetails.stock ?? 0,
                initialStock: productDetails.initialStock ?? 0,
                variants: [],
                image: productDetails.image,
              );
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: config.appVerticalPaddingSmall(),
                    horizontal: config.appHorizontalPaddingMedium()),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProductImageCarousel(
                      selectedVariant.value?.image ?? productDetails.image,
                    ),
                    buildVariantSelector(
                      productDetails.variantDetails,
                      selectedVariant,
                    ),
                    buildProductInfo(
                        selectedVariant.value!, productDetails.name),
                    buildReviewSection(productDetails.averageRating),

                    buildAddToCartSection(selectedVariant.value?.minOrder,
                        selectedVariant.value?.maxOrder),
                    buildDescriptionAndSpecifications(productDetails),
                    // buildMessageSellerSection(context),
                  ],
                ),
              );
            },
            failure: (value) => const Center(
              child: Text('There is no data'),
            ),
          )), floatingWidget:  FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => const MessageSellerDialog(),
          );
        },
        child: const Icon(Icons.message, size: 20),
      ), floatingWidgetWidth: 50, floatingWidgetHeight: 50);
    });
  }
}
