import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_form_controller.dart';
import 'package:sizer/sizer.dart';

class StoFilterItemsScreen extends GetView<StoFormController> {
  const StoFilterItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: searchField(context, controller)),
          Expanded(
              flex: 6,
              child: Obx(
                () => controller.listSto.isNotEmpty
                    ? listItemDataS(context, controller)
                    : const Text("Data bahan tidak ada, pilih gudang lain."),
              )),
        ],
      ),
    );
  }
}

Container listItemDataS(BuildContext context, StoFormController controller) {
  return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Obx(() {
            return ListView.separated(
                controller: controller.sc.value,
                itemBuilder: (context, index) {
                  if (index < controller.listSto.length) {
                    return Card(
                      elevation: 2,
                      shadowColor: Colors.green,
                      // color: Color(0xFFE9E9E9),
                      margin: const EdgeInsets.all(1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                          child: ListTile(
                        leading: const Icon(
                          Icons.arrow_right,
                          color: Colors.amberAccent,
                          size: 50,
                        ),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              controller.listSto.value[index].items!.name ?? '',
                              textScaleFactor: 0.8,
                            ),
                            const Spacer(),
                            Text(
                              'Per / ${controller.listSto.value[index].items!.unit ?? ''}',
                              textScaleFactor: 0.8,
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.insertItemToList(index);
                        },
                      )),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: const Center(
                        child: Text("Tidak ada lagi bahan"),
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: controller.listSto.value.length +
                    (controller.allLoaded.value ? 1 : 0));
          }),
          if (controller.loading.isTrue) ...[
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ]
        ],
      ));
}

Container searchField(BuildContext context, StoFormController controller) {
  return Container(
    // width: MediaQuery.of(context).size.width * .66,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        // color: primaryGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)),
    child: TextField(
      textInputAction: TextInputAction.search,
      controller: controller.textFieldController.value,
      // onChanged: (value) => _controller.changeTotalPerPage(10, value),
      onSubmitted: (value) => controller.searchData(),
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: "Cari...",
        filled: true,
        suffixIcon: IconButton(
            onPressed: () {
              controller.clearValueSearch();
            },
            icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
        // icon: const Icon(Icons.clear),
        prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
        contentPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
      ),
    ),
  );
}
