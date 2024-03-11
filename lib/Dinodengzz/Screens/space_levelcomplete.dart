import 'package:end_credits/end_credits.dart';
import 'package:flutter/material.dart';

class LevelCompleteBoss extends StatelessWidget {
  final VoidCallback onExitPressed;

  const LevelCompleteBoss({
    required this.onExitPressed,
    super.key,
  });

  static const id = 'LevelCompleteBoss';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: EndCredits(
              [
                Section(title: '---Directors---', roles: [
                  Role(
                      name: 'Director',
                      crew: [const Responsable('PUMIN SITTIWARANON')]),
                  Role(
                      name: 'Co Director',
                      crew: [const Responsable('SIRAPOB CHORMPINTA')]),
                ]),
                Section(title: '---Programmer---', roles: [
                  Role(
                      name: 'Lead Programmer',
                      crew: [const Responsable('PUMIN SITTIWARANON')]),
                ]),
                Section(title: '---Game Designers---', roles: [
                  Role(name: 'Level Designer', crew: [
                    const Responsable('SIRAPOB CHORMPINTA'),
                  ]),
                  Role(name: 'Gameplay Designer', crew: [
                    const Responsable('PUMIN SITTIWARANON'),
                  ])
                ]),
                Section(title: '---Graphic Artist---', roles: [
                  Role(name: 'Character Artist', crew: [
                    const Responsable('SIRAPOB CHORMPINTA'),
                  ]),
                  Role(name: 'UI Artist', crew: [
                    const Responsable('SIRAPOB CHORMPINTA'),
                  ]),
                  Role(name: 'Advisor', crew: [
                    const Responsable('THEERAPHAT CHANSOONTRAPORN'),
                  ]),
                ]),
                Section(title: '---Sound Designers---', roles: [
                  Role(name: 'Music Composer', crew: [
                    const Responsable('NATTAKARN KHUMSUPHA'),
                  ]),
                  Role(name: 'Sound Effect Designer', crew: [
                    const Responsable('PICHANMET MEETA'),
                  ])
                ]),
                Section(title: '---Cast---', roles: [
                  Role(name: 'Relax', crew: [
                    const Responsable('THEERAPHAT CHANSOONTRAPORN'),
                  ])
                ]),
                Section(title: '---Special Thank---', roles: [
                  Role(name: 'Flame Guideline', crew: [
                    const Responsable('Spellthorn'),
                    const Responsable('DevKage'),
                  ]),
                  Role(name: 'Assets', crew: [
                    const Responsable('Pixel Frog'),
                    const Responsable('GrafxKid'),
                  ]),
                  Role(name: 'Inspiration', crew: [
                    const Responsable('Palworld'),
                    const Responsable('Kung Fu Panda'),
                  ]),
                ]),
                Section(title: '---RuamMitr Member---', roles: [
                  Role(name: 'RuamMitr Main', crew: [
                    const Responsable('CHANATHIP YODKHUANG'),
                    const Responsable('NATTAKARN KHUMSUPHA'),
                  ]),
                  Role(name: 'TuaChuay Dekhor', crew: [
                    const Responsable('NICHAREE MALARAT'),
                    const Responsable('KASIDIT CHUNPEN'),
                  ]),
                  Role(name: 'RestRoomRover', crew: [
                    const Responsable('NUTPAPOP YASAWUT'),
                    const Responsable('SAHIRUN NOIPRASERT'),
                  ]),
                  Role(name: 'Pin The Bin', crew: [
                    const Responsable('NUTTAWON JITWARODOM'),
                    const Responsable('NUTCHA PINGHAN'),
                  ]),
                  Role(name: 'DinoDengzz', crew: [
                    const Responsable('PUMIN SITTIWARANON'),
                    const Responsable('SIRAPOB CHORMPINTA'),
                  ]),
                  Role(name: 'Backend Developer', crew: [
                    const Responsable('TAPANAWAT MUANGSRI'),
                  ]),
                  Role(name: 'Support', crew: [
                    const Responsable('KRITTITHAD VIBOONSUNTI'),
                  ]),
                ]),
                Section(title: '---THE MOST SUPPORT---', roles: [
                  Role(name: 'YOU', crew: [const Responsable('')]),
                ]),
              ],
              curve: Curves.linear,
              responsableTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: 15,
              ),
              roleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: 20,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.012,
            right: MediaQuery.of(context).size.width * 0.036,
            child: GestureDetector(
              onTap: onExitPressed,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.069,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
