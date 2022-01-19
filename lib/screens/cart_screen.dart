import 'package:electronic_shop/providers/products_provider.dart';
import 'package:electronic_shop/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final ProductsProvider productsProvider;
  @override
  void initState() {
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    final cartItemsProvider = Provider.of<ProductsProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: cartItemsProvider.cartProducts.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      itemCount: cartItemsProvider.cartProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.75,
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (BuildContext context, int index) {
                        final product = cartItemsProvider.cartProducts[index];
                        return ProductTile(
                          product: product,
                          productsProvider: productsProvider,
                        );
                      },
                    ),
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey[200],
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Items : ${cartItemsProvider.cartProducts.length}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Total Price : \$ ${cartItemsProvider.totalPrice}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/checkout');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.green,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Text(
                                'Checkout',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('No items added to cart'),
              ),
      ),
    );
  }
}
