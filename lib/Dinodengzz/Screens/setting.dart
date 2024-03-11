import 'package:flutter/material.dart';

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
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 1,
            child: Image.asset(
              "assets/images/DinoDengzz Icon/Sound setting no line and button.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.069),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.062),
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
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01),
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
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              ),
            ],
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
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005),
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
