import "package:flutter/material.dart";
import "package:ruam_mitt/global_const.dart";
import "package:ruam_mitt/global_var.dart";

class BinDrawer extends StatelessWidget {
  const BinDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ThemeProvider themes = Provider.of<ThemeProvider>(context);
    // ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    // print(pinTheBinTheme.colorScheme.primary);
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 30, top: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFF9957F),
              Color(0xFFF3F6D1),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(profileData['imgPath']),
                  width: size.width * 0.15,
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  profileData["fullname"] ?? "John Doe",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  ),
                  Container(
                    width: size.width - 124 - 30,
                    height: 1.3,
                    decoration: const BoxDecoration(color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18),
              child: Column(
                children: [
                  itemSelection(
                    context: context,
                    title: "HOME",
                    image: Image.asset(
                      "assets/images/PinTheBin/home.png",
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
                    },
                  ),
                  const SizedBox(height: 30),
                  itemSelection(
                    context: context,
                    title: "ADD BIN",
                    image: Image.asset(
                      "assets/images/PinTheBin/add_bin.png",
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, pinthebinPageRoute["addbin"]!);
                    },
                  ),
                  const SizedBox(height: 30),
                  itemSelection(
                    context: context,
                    title: "EDIT MY BIN",
                    image: Image.asset(
                      "assets/images/PinTheBin/edit_bin.png",
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, pinthebinPageRoute["editbin"]!);
                    },
                  ),
                  const SizedBox(height: 30),
                  itemSelection(
                    context: context,
                    title: "REPORT",
                    image: Image.asset(
                      "assets/images/PinTheBin/report.png",
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, pinthebinPageRoute["report"]!);
                    },
                  ),
                  const SizedBox(height: 30),
                  itemSelection(
                    context: context,
                    title: "RUAMMITR",
                    image: Image.asset(
                      "assets/Logo/ruammitr_logo_for_bin.png",
                      width: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        ruamMitrPageRoute["homev2"]!,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        // child: Stack(
        //   children: [
        //     ListView(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 40),
        //           child: AvatarViewer(themeData: pinTheBinThemeData),
        //         ),
        //         ListTile(
        //           title: const Text('PinTheBin Home'),
        //           trailing: const Icon(Icons.double_arrow),
        //           onTap: () {
        //             Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
        //           },
        //         ),
        //         ListTile(
        //           title: const Text('Add Bin'),
        //           trailing: const Icon(Icons.double_arrow),
        //           onTap: () {
        //             Navigator.pushNamed(context, pinthebinPageRoute["addbin"]!);
        //           },
        //         ),
        //         ListTile(
        //           title: const Text('Edit Bin'),
        //           trailing: const Icon(Icons.double_arrow),
        //           onTap: () {
        //             Navigator.pushNamed(
        //                 context, pinthebinPageRoute["editbin"]!);
        //           },
        //         ),
        //         ListTile(
        //           title: const Text('Report'),
        //           trailing: const Icon(Icons.double_arrow),
        //           onTap: () {
        //             Navigator.pushNamed(context, pinthebinPageRoute["report"]!);
        //           },
        //         ),
        //       ],
        //     ),
        //     Positioned(
        //       bottom: size.height * 0.05,
        //       left: size.width * 0.05,
        //       child: GestureDetector(
        //         child: Container(
        //           height: size.height * 0.05,
        //           width: size.height * 0.05,
        //           decoration: const BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: Colors.white,
        //           ),
        //           child: const Icon(Icons.exit_to_app),
        //         ),
        //         onTap: () {
        //           print("Back to Home");
        //           Navigator.of(context).pushNamedAndRemoveUntil(
        //             ruamMitrPageRoute["homev2"]!,
        //             (route) => false,
        //           );
        //         },
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

Widget itemSelection({
  required String title,
  required Widget image,
  required void Function() onTap,
  required BuildContext context,
}) {
  return InkWell(
    onTap: onTap,
    child: Ink(
      child: Row(children: [
        image,
        const SizedBox(width: 30),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        )
      ]),
    ),
  );
}
