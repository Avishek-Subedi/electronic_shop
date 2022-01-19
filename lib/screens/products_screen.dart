import 'package:electronic_shop/entiies/product_model.dart';
import 'package:electronic_shop/providers/products_provider.dart';
import 'package:electronic_shop/screens/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FilterBy? filterBy;
  late final ProductsProvider productsProvider;
  @override
  void initState() {
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    getData();
    super.initState();
  }

  void getData() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      productsProvider.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final response = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            value: filterBy,
            hint: Text(
              'Filter By',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            items: const [
              DropdownMenuItem(
                child: Text('Price'),
                value: FilterBy.price,
              ),
              DropdownMenuItem(
                child: Text('Category'),
                value: FilterBy.category,
              ),
            ],
            onChanged: (value) {
              setState(() {
                filterBy = value as FilterBy;
              });
              productsProvider.filterProducts(filterBy);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
          return;
        },
        child: response.loading
            ? GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemBuilder: (BuildContext context, int index) {
                  return const CustomShimmer();
                },
              )
            : response.productsList.data?.product?.isNotEmpty ?? false
                ? GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    itemCount: response.productsList.data?.product?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      final product =
                          response.productsList.data!.product![index];
                      return ProductTile(
                        product: product,
                        productsProvider: productsProvider,
                      );
                    },
                  )
                : const Center(
                    child: Text('No products found !'),
                  ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.product,
    required this.productsProvider,
  }) : super(key: key);

  final Product product;
  final ProductsProvider productsProvider;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<ProductsProvider>(context).cartProducts;
    final hasInCart = cartItems.contains(product);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.network(
                product.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Name : ${product.name ?? ''}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'Price : ${product.price ?? ''}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text('Available Stock : ${product.stock.toString()}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category : ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ...product.category
                      ?.map((e) => Text(
                            '$e ',
                            style: Theme.of(context).textTheme.subtitle2,
                          ))
                      .toList() ??
                  []
            ],
          ),
          InkWell(
            onTap: () {
              productsProvider.addToCart(product);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: hasInCart ? Colors.red : Colors.green,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                hasInCart ? 'Remove from cart' : 'Add to cart',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
