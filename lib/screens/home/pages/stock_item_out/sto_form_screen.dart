import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_form_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/components/sto_filter_item.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/components/sto_form.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StoFormScreen extends GetView<StoFormController> {
  const StoFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .70;
    Size size = MediaQuery.of(context).size;
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    var appBar = buildAppBar(controller);
    var node = FocusScope.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(0, 237, 248, 243),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: appBar,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.openClosePanelControl();
          },
          backgroundColor: primaryYellow,
          child: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        // body: const Body(),
        body: SlidingUpPanel(
          maxHeight: controller.panelHeightOpen,
          minHeight: controller.panelHeightClosed,
          controller: controller.pcs,
          parallaxEnabled: true,
          parallaxOffset: .10,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          panel: const Center(
            child: StoFilterItemsScreen(),
          ),
          body: const StoForm(),
        ),
      ),
    );
  }

  AppBar buildAppBar(StoFormController controller) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      elevation: 0,
      backgroundColor: primaryYellow,
      // automaticallyImplyLeading: false,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              Get.back(result: controller.isUpdate.value);
            },
            // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: const Text(
        'Keluarkan Bahan',
        style: TextStyle(color: Color(0xFF2A2A2A)),
      ),
      centerTitle: true,
      actions: [
        Obx(
          () => TextButton(
            style: TextButton.styleFrom(
              elevation: 0,
              primary: const Color(0xFF0A64FF),
              backgroundColor: Colors.transparent,
              onSurface: Colors.grey,
              padding: EdgeInsets.zero,
              // minimumSize: const Size(50, 50),
              alignment: Alignment.center,
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            onPressed: controller.it.isNotEmpty
                ? () {
                    Get.defaultDialog(
                        title: "Submit?",
                        middleText:
                            "Anda akan ingin membuat orderan ini, lanjutkan?",
                        backgroundColor: whiteBg,
                        titleStyle: const TextStyle(color: mtGrey700),
                        middleTextStyle: const TextStyle(color: mtGrey700),
                        textConfirm: confirmYes,
                        textCancel: confirmNo,
                        cancelTextColor: mtGrey700,
                        confirmTextColor: mtGrey700,
                        buttonColor: primaryYellow,
                        onConfirm: () {
                          Get.back();
                          controller.submitOut();
                        });
                  }
                : null,
            child: const Text(
              'Ubah',
              style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
