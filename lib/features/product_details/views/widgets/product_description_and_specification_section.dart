import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/model/product_details_model.dart';

Widget buildDescriptionAndSpecifications(Product product) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: [
         TabBar(
          labelColor: Colors.black,
          labelStyle:  const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
           labelPadding: const EdgeInsets.only(top: 10),
          tabs: [
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 34,
                child: const Text(
                  'Description',
                )),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 34,
                child: const Text(
                  'Specifications',
                )),
            // Tab(text: "Description"),
            // Tab(text: "Specifications"),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            children: [
              // Text(product.description),
              SingleChildScrollView(
                child: Html(
                  data: product.description,
                  style: {
                    "h3": Style(fontSize: FontSize.large, fontWeight: FontWeight.bold),
                    "p": Style(fontSize: FontSize.medium),
                  },
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: product.specification.map((spec) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          // Type with flex: 1, bold font weight
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${spec.type}:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Value with flex: 3
                          Expanded(
                            flex: 3,
                            child: Text(
                              spec.value,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
