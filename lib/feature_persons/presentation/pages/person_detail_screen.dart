import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rick_morty/common/app_colors.dart';
import 'package:rick_morty/feature_persons/domain/entities/person_entity.dart';
import 'package:rick_morty/feature_persons/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personagem'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            // Имя персонажа
            Text(
              person.name,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            // Изображение персонажа
            Container(
              child: PersonCacheImage(
                imageUrl: person.image,
                width: 320,
                height: 320,
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            if (person.type.isNotEmpty)...buildText('Tipo', person.type),
            ...buildText('Genero', person.gender),
            ...buildText('Numero de Episodios:', person.episode.length.toString()),
            ...buildText('Especie:', person.species),
            ...buildText('localização conhecida:', person.location.name),
            ...buildText('Origem:', person.origin.name),
            ...buildText('Criação:', person.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: TextStyle(
          color: AppColors.Background3,
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 12,
      ),
    ];
  }
}
