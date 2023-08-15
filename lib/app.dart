import 'package:bloc_to_communication/bloc/license_bloc.dart';
import 'package:bloc_to_communication/bloc/product_bloc.dart';
import 'package:bloc_to_communication/components/buy_btn.dart';
import 'package:bloc_to_communication/components/loading.dart';
import 'package:bloc_to_communication/components/lock_widget.dart';
import 'package:bloc_to_communication/components/products_widget.dart';
import 'package:bloc_to_communication/event/license_event.dart';
import 'package:bloc_to_communication/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc to communication'),
      ),

      /// 화면에서 hasLicense값을 처리하는 방법
      // body: BlocListener<LicenseBloc, LicenseState>(
      //   listener: (context, state) {
      //     if (state.hasLicense) {
      //       context
      //           .read<ProductBloc>()
      //           .add(PayLoadProductEvent(state.hasLicense));
      //     }
      //   },
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: const [
      //       _DefaultItems(),
      //       SizedBox(height: 50),
      //       _PayItems(),
      //     ],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _DefaultItems(),
          SizedBox(height: 50),
          _PayItems(),
        ],
      ),
      bottomNavigationBar: BuyBtn(
        onTap: () {
          context.read<LicenseBloc>().add(BuyLicenseEvent());
        },
      ),
    );
  }
}

class _DefaultItems extends StatelessWidget {
  const _DefaultItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            '기본 권한 아이템',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (state is LoadingProductState) const Loading(),
        if (state is LoadedProductState)
          ProductsWidget(
            items: List.generate(
              state.defaultItems?.length ?? 0,
              (index) => state.defaultItems![index],
            ),
          ),
      ],
    );
  }
}

class _PayItems extends StatelessWidget {
  const _PayItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            '유료 권한 아이템',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (state is LoadingProductState) const Loading(),
        if (state is LoadedProductState && state.payItems == null)
          const LockWidget(),
        if (state is LoadedProductState && state.payItems != null)
          ProductsWidget(
            items: List.generate(
              state.defaultItems?.length ?? 0,
              (index) => state.defaultItems![index],
            ),
          ),
      ],
    );
  }
}
