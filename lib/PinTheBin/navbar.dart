import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:ruam_mitt/RuamMitr/Component/avatar.dart";
import "package:ruam_mitt/RuamMitr/Component/theme.dart";
import "package:ruam_mitt/global_const.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeProvider themes = Provider.of<ThemeProvider>(context);
    ThemeData pinTheBinTheme = themes.themeFrom("PinTheBin")!.themeData;
    print(pinTheBinTheme.colorScheme.primary);
    return Theme(
      data: pinTheBinTheme,
      child: Drawer(
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: AvatarViewer(themeData: pinTheBinTheme),
                ),
                ListTile(
                  title: const Text('PinTheBin Home'),
                  trailing: const Icon(Icons.double_arrow),
                  onTap: () {
                    Navigator.pushNamed(context, pinthebinPageRoute["home"]!);
                  },
                ),
                ListTile(
                  title: const Text('Add Bin'),
                  trailing: const Icon(Icons.double_arrow),
                  onTap: () {
                    Navigator.pushNamed(context, pinthebinPageRoute["addbin"]!);
                  },
                ),
                ListTile(
                  title: const Text('Edit Bin'),
                  trailing: const Icon(Icons.double_arrow),
                  onTap: () {
                    Navigator.pushNamed(
                        context, pinthebinPageRoute["editbin"]!);
                  },
                ),
                ListTile(
                  title: const Text('Report'),
                  trailing: const Icon(Icons.double_arrow),
                  onTap: () {
                    Navigator.pushNamed(context, pinthebinPageRoute["report"]!);
                  },
                ),
              ],
            ),
            Positioned(
              bottom: size.height * 0.05,
              left: size.width * 0.05,
              child: GestureDetector(
                child: Container(
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.exit_to_app),
                ),
                onTap: () {
                  print("Back to Home");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    ruamMitrPageRoute["homev2"]!,
                    (route) => false,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
