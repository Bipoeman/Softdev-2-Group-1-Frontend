import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final ValueChanged<double>? onMasterVolumeChanged;
  final ValueChanged<double>? onBgmVolumeChanged;
  final ValueChanged<double>? onSfxVolumeChanged;
  final VoidCallback? onSkipDialogPressed;
  final VoidCallback? onSkipDialogCancel;
  final double masterVolume;
  final double bgmVolume;
  final double sfxVolume;

  const Settings({
    super.key,
    this.onBackPressed,
    this.onMasterVolumeChanged,
    this.onBgmVolumeChanged,
    this.onSfxVolumeChanged,
    required this.masterVolume,
    required this.bgmVolume,
    required this.sfxVolume,
    this.onSkipDialogPressed,
    this.onSkipDialogCancel,
  });

  static const id = 'Settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double masterVolume;
  late double bgmVolume;
  late double sfxVolume;
  late bool skipDialogEnabled;

  @override
  void initState() {
    super.initState();
    masterVolume = widget.masterVolume * 100;
    bgmVolume = widget.bgmVolume * 100;
    sfxVolume = widget.sfxVolume * 100;
    skipDialogEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 1, 12, 38),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(
                    'Master Volume',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  _buildSlider(
                    value: masterVolume,
                    onChanged: (value) {
                      setState(() {
                        masterVolume = value;
                      });
                      if (widget.onMasterVolumeChanged != null) {
                        widget.onMasterVolumeChanged!(value);
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(
                    'BGM Volume',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  _buildSlider(
                    value: bgmVolume,
                    onChanged: (value) {
                      setState(() {
                        bgmVolume = value;
                      });
                      if (widget.onBgmVolumeChanged != null) {
                        widget.onBgmVolumeChanged!(value);
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(
                    'SFX Volume',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  _buildSlider(
                    value: sfxVolume,
                    onChanged: (value) {
                      setState(() {
                        sfxVolume = value;
                      });
                      if (widget.onSfxVolumeChanged != null) {
                        widget.onSfxVolumeChanged!(value);
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Switch(
                    value: skipDialogEnabled,
                    onChanged: (value) {
                      setState(() {
                        skipDialogEnabled = value;
                      });
                      if (value) {
                        widget.onSkipDialogPressed?.call();
                      } else {
                        widget.onSkipDialogCancel?.call();
                      }
                    },
                    activeColor: Colors.white,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0069),
                  const Text(
                    'Skip Dialog',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              IconButton(
                onPressed: widget.onBackPressed,
                icon: Image.asset(
                  "assets/images/DinoDengzz Icon/White Back Button.png",
                ),
                iconSize: MediaQuery.of(context).size.width * 0.03,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Sound Settings',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.667,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color.fromARGB(255, 255, 255, 255),
            inactiveTrackColor: const Color.fromARGB(255, 81, 81, 81),
            thumbColor: const Color.fromARGB(255, 255, 255, 255),
            valueIndicatorColor: Colors.black,
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
            min: 0,
            max: 100,
            divisions: 100,
            label: value.round().toString(),
          ),
        ),
      ),
    );
  }
}
