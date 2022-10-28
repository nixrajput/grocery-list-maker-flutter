import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/constants/colors.dart';
import 'package:grocery_list_maker/constants/strings.dart';
import 'package:grocery_list_maker/global_widgets/loading_widget.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/modules/grocery_list/cubit/grocery_list_cubit.dart';
import 'package:grocery_list_maker/modules/grocery_list/views/add_edit_list_view.dart';
import 'package:grocery_list_maker/modules/grocery_list/views/grocery_list_detail_view.dart';
import 'package:grocery_list_maker/modules/grocery_list/widgets/grocery_list_card.dart';
import 'package:grocery_list_maker/modules/settings/settings_view.dart';
import 'package:grocery_list_maker/utils/utility.dart';

class GroceryListView extends StatefulWidget {
  const GroceryListView({super.key});

  @override
  State<GroceryListView> createState() => _GroceryListViewState();
}

class _GroceryListViewState extends State<GroceryListView> {
  @override
  void initState() {
    context.read<GroceryListCubit>().getGroceryLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 8.0),
                    _buildBody(context),
                  ],
                ),
                Positioned(
                  bottom: 12.0,
                  right: 12.0,
                  left: 12.0,
                  child: _buildAddButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddEditListView(initialItem: null),
          ),
        );
      },
      child: Container(
        height: 56.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'Add New List'.toUpperCase(),
            style: const TextStyle(
              color: lightColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildBody(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: BlocConsumer<GroceryListCubit, GroceryListState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              AppUtility.showSnackBar(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case GroceryListStatus.initial:
                return _buildEmptyWidget(deviceSize);
              case GroceryListStatus.loading:
                return const LoadingWidget();
              case GroceryListStatus.success:
              case GroceryListStatus.failure:
                if (state.groceryLists.isEmpty) {
                  return _buildEmptyWidget(deviceSize);
                }

                state.groceryLists
                    .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.groceryLists.length,
                  itemBuilder: (context, index) {
                    final groceryList = state.groceryLists[index];
                    return GroceryListCard(
                      item: groceryList,
                      onViewBtn: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return GroceryListDetailView(
                                initialItem: groceryList,
                              );
                            },
                          ),
                        );
                      },
                      onEditBtn: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return AddEditListView(
                              initialItem: groceryList,
                            );
                          },
                        ),
                      ),
                      onDeleteBtn: () => context
                          .read<GroceryListCubit>()
                          .deleteGroceryList(groceryList.id),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  Column _buildEmptyWidget(Size deviceSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/empty_cart.svg",
          width: deviceSize.width * 0.25,
          height: deviceSize.height * 0.25,
        ),
        const SizedBox(height: 20.0),
        const Center(
          child: Text(
            'Start adding your grocery lists',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            appName,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const SettingsView();
                  },
                ),
              );
            },
            child: const Icon(
              Icons.settings,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
