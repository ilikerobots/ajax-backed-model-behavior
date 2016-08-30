import 'package:ghpages_generator/ghpages_generator.dart' as gh;

main() {
  new gh.Generator()..withExamples = true
                    ..withIndexGeneration = true
                    ..generate();
}

