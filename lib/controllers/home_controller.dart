import 'package:myschool/models/modules.dart';
import 'package:myschool/utils/constants/image_strings.dart';

import '../utils/constants/enums.dart';

class HomeController {
  late List<Module> modules;

  HomeController({required int level, String? branch}) {
    modules = getUserModules(level: level, branch: branch);
  }

  List<Module> getUserModules({required int level, String? branch}) {
    switch (level) {
      case 12:
        {
          if (branch == Branches.gestion.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.accounting,
                  imagePath: SImageString.moduleAccounting),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.economy,
                  imagePath: SImageString.moduleEconomy),
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                module: ModuleEnum.law,
                imagePath: SImageString.moduleLaw,
              ),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
            ];
          } else if (branch == Branches.langue.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.german,
                  imagePath: SImageString.moduleGerman),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.italian,
                  imagePath: SImageString.moduleItalian),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.spanish,
                  imagePath: SImageString.moduleSpanish),
            ];
          } else if (branch == Branches.philosophie.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
            ];
          } else if (branch == Branches.mathTechnique.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.civilEngineering,
                  imagePath: SImageString.moduleCivilEngineering),
              Module(
                  module: ModuleEnum.electricalEngineering,
                  imagePath: SImageString.moduleElectricalEngineering),
              Module(
                  module: ModuleEnum.physics,
                  imagePath: SImageString.modulePhysics),
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.mechanicalEngineering,
                  imagePath: SImageString.moduleMichanicalEngineering),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
              Module(
                  module: ModuleEnum.processEngineering,
                  imagePath: SImageString.moduleProcessEngineering),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
            ];
          } else {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.physics,
                  imagePath: SImageString.modulePhysics),
              Module(
                  module: ModuleEnum.science,
                  imagePath: SImageString.moduleScience),
            ];
          }
        }
      case 11:
        {
          if (branch == Branches.gestion.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.accounting,
                  imagePath: SImageString.moduleAccounting),
              Module(
                  module: ModuleEnum.economy,
                  imagePath: SImageString.moduleEconomy),
              Module(module: ModuleEnum.law, imagePath: SImageString.moduleLaw),
            ];
          } else if (branch == Branches.langue.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.german,
                  imagePath: SImageString.moduleGerman),
              Module(
                  module: ModuleEnum.italian,
                  imagePath: SImageString.moduleItalian),
              Module(
                  module: ModuleEnum.spanish,
                  imagePath: SImageString.moduleSpanish),
            ];
          } else if (branch == Branches.philosophie.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.science,
                  imagePath: SImageString.moduleScience),
              Module(
                  module: ModuleEnum.philosophy,
                  imagePath: SImageString.modulePhilosophy),
              Module(
                  module: ModuleEnum.physics,
                  imagePath: SImageString.modulePhysics),
            ];
          } else if (branch == Branches.mathTechnique.name) {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.mechanicalEngineering,
                  imagePath: SImageString.moduleMichanicalEngineering),
              Module(
                  module: ModuleEnum.processEngineering,
                  imagePath: SImageString.moduleProcessEngineering),
              Module(
                  module: ModuleEnum.civilEngineering,
                  imagePath: SImageString.moduleCivilEngineering),
              Module(
                  module: ModuleEnum.electricalEngineering,
                  imagePath: SImageString.moduleElectricalEngineering),
              Module(
                  module: ModuleEnum.physics,
                  imagePath: SImageString.modulePhysics),
            ];
          } else {
            return <Module>[
              Module(
                  module: ModuleEnum.english,
                  imagePath: SImageString.moduleEnglish),
              Module(
                  module: ModuleEnum.french,
                  imagePath: SImageString.moduleFrench),
              Module(
                  module: ModuleEnum.sharia,
                  imagePath: SImageString.moduleShariaa),
              Module(
                  module: ModuleEnum.geography,
                  imagePath: SImageString.moduleGeography),
              Module(
                  module: ModuleEnum.maths,
                  imagePath: SImageString.moduleMaths),
              Module(
                  module: ModuleEnum.history,
                  imagePath: SImageString.moduleHistory),
              Module(
                  module: ModuleEnum.arabic,
                  imagePath: SImageString.moduleArabic),
              Module(
                  module: ModuleEnum.science,
                  imagePath: SImageString.moduleScience),
              Module(
                  module: ModuleEnum.physics,
                  imagePath: SImageString.modulePhysics),
            ];
          }
        }

      case 10:
        {
          // if (branch == Branches.literature.name) {
          return <Module>[
            Module(
                module: ModuleEnum.english,
                imagePath: SImageString.moduleEnglish),
            Module(
                module: ModuleEnum.french,
                imagePath: SImageString.moduleFrench),
            Module(
                module: ModuleEnum.sharia,
                imagePath: SImageString.moduleShariaa),
            Module(
                module: ModuleEnum.geography,
                imagePath: SImageString.moduleGeography),
            Module(
                module: ModuleEnum.maths, imagePath: SImageString.moduleMaths),
            Module(
                module: ModuleEnum.history,
                imagePath: SImageString.moduleHistory),
            Module(
                module: ModuleEnum.arabic,
                imagePath: SImageString.moduleArabic),
            Module(
                module: ModuleEnum.science,
                imagePath: SImageString.moduleScience),
            Module(
                module: ModuleEnum.physics,
                imagePath: SImageString.modulePhysics),
            Module(
                module: ModuleEnum.computerScience,
                imagePath: SImageString.moduleComputerScience),
          ];
        }
      // else {
      //   return <ModuleEnum>[
      //     ModuleEnum.arabic,
      //     ModuleEnum.english,
      //     ModuleEnum.french,
      //     ModuleEnum.geography,
      //     ModuleEnum.history,
      //     ModuleEnum.maths,
      //     ModuleEnum.physics,
      //     ModuleEnum.science,
      //     ModuleEnum.sharia,
      //     ModuleEnum.computerScience,
      //   ];
      // }
      // }
      case 9 || 8 || 7 || 6:
        {
          return <Module>[
            Module(
                module: ModuleEnum.english,
                imagePath: SImageString.moduleEnglish),
            Module(
                module: ModuleEnum.french,
                imagePath: SImageString.moduleFrench),
            Module(
                module: ModuleEnum.sharia,
                imagePath: SImageString.moduleShariaa),
            Module(
                module: ModuleEnum.geography,
                imagePath: SImageString.moduleGeography),
            Module(
                module: ModuleEnum.maths, imagePath: SImageString.moduleMaths),
            Module(
                module: ModuleEnum.history,
                imagePath: SImageString.moduleHistory),
            Module(
                module: ModuleEnum.arabic,
                imagePath: SImageString.moduleArabic),
            Module(
                module: ModuleEnum.science,
                imagePath: SImageString.moduleScience),
            Module(
                module: ModuleEnum.physics,
                imagePath: SImageString.modulePhysics),
            Module(
                module: ModuleEnum.computerScience,
                imagePath: SImageString.moduleComputerScience),
            Module(
                module: ModuleEnum.civil, imagePath: SImageString.moduleCivil),
          ];
        }
      case 5:
        {
          return <Module>[
            Module(
                module: ModuleEnum.french,
                imagePath: SImageString.moduleFrench),
            Module(
                module: ModuleEnum.sharia,
                imagePath: SImageString.moduleShariaa),
            Module(
                module: ModuleEnum.geography,
                imagePath: SImageString.moduleGeography),
            Module(
              module: ModuleEnum.maths,
              imagePath: SImageString.moduleMaths,
            ),
            Module(
                module: ModuleEnum.history,
                imagePath: SImageString.moduleHistory),
            Module(
                module: ModuleEnum.arabic,
                imagePath: SImageString.moduleArabic),
            Module(
                module: ModuleEnum.technology,
                imagePath: SImageString.moduleTechnology),
            Module(
                module: ModuleEnum.civil, imagePath: SImageString.moduleCivil),
          ];
        }
      case 4 || 3:
        {
          return <Module>[
            Module(
                module: ModuleEnum.english,
                imagePath: SImageString.moduleEnglish),
            Module(
                module: ModuleEnum.french,
                imagePath: SImageString.moduleFrench),
            Module(
                module: ModuleEnum.sharia,
                imagePath: SImageString.moduleShariaa),
            Module(
                module: ModuleEnum.geography,
                imagePath: SImageString.moduleGeography),
            Module(
              module: ModuleEnum.maths,
              imagePath: SImageString.moduleMaths,
            ),
            Module(
                module: ModuleEnum.history,
                imagePath: SImageString.moduleHistory),
            Module(
                module: ModuleEnum.arabic,
                imagePath: SImageString.moduleArabic),
            Module(
                module: ModuleEnum.technology,
                imagePath: SImageString.moduleTechnology),
            Module(
                module: ModuleEnum.civil, imagePath: SImageString.moduleCivil),
          ];
        }
      case 2 || 1:
        {
          return <Module>[
            Module(
                module: ModuleEnum.english,
                imagePath: SImageString.moduleEnglish),
            Module(
                module: ModuleEnum.french,
                imagePath: SImageString.moduleFrench),
            Module(
                module: ModuleEnum.sharia,
                imagePath: SImageString.moduleShariaa),
            Module(
              module: ModuleEnum.maths,
              imagePath: SImageString.moduleMaths,
            ),
            Module(
                module: ModuleEnum.arabic,
                imagePath: SImageString.moduleArabic),
            Module(
                module: ModuleEnum.technology,
                imagePath: SImageString.moduleTechnology),
            Module(
                module: ModuleEnum.civil, imagePath: SImageString.moduleCivil),
          ];
        }
      default:
        return <Module>[];
    }
  }
}
