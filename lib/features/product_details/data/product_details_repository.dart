import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_details/core/data/remote/api_client.dart';
import 'package:product_details/features/product_details/data/model/product_details_model.dart';

import '../../../core/utils/connectivity_checker.dart';
import '../../../core/utils/constants.dart';

abstract class ProductDetailsRepository {
  Future<Either<String, Product>> getProductDetails(String productName);
}

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  @override
  Future<Either<String, Product>> getProductDetails(String productName) async {
    try {
      ApiClient client = ApiClient(
          baseUrl: 'https://api.melabazaar.com.np/api/v1/', dio: Dio());

      bool isConnected = await checkInternetConnection();
      if (!isConnected) {
        return Left(noInternetConnection);
      }
      final response = await client.get('items/product_list/$productName/',
          queryParameters: {'format': "json"});
      if (response == null || response['data'] == null) {
        return const Left("No product details found");
      }

      final productData = response['data'];

      final product = Product.fromJson(productData);

      return Right(product);
    } catch (e) {
      if(e is DioException) {
        return Left("${e.message}");
      }else{
        return const Left('Something went wrong!');
      }
    }
  }
}

final productDetailsRepositoryProvider =
    Provider<ProductDetailsRepository>((ref) => ProductDetailsRepositoryImpl());
