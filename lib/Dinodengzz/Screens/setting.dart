import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final ValueChanged<double>? onMasterVolumeChanged;
  final ValueChanged<double>? onBgmVolumeChanged;
  final ValueChanged<double>? onSfxVolumeChanged;
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
  });

  static const id = 'Settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double masterVolume;
  late double bgmVolume;
  late double sfxVolume;

  @override
  void initState() {
    super.initState();
    masterVolume = widget.masterVolume * 100;
    bgmVolume = widget.bgmVolume * 100;
    sfxVolume = widget.sfxVolume * 100;
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.036),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0323),
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
                  IconButton(
                    onPressed: widget.onBackPressed,
                    icon: Image.asset(
                      "assets/images/DinoDengzz Icon/White Back Button.png",
                    ),
                    iconSize: MediaQuery.of(context).size.width * 0.00001,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.00001),
                  ),
                ],
              ),
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
