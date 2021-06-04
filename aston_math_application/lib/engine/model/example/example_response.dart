import 'package:json_annotation/json_annotation.dart';

part 'example_response.g.dart';

//NEED TO USE: flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class ExampleResponse {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'original_title')
  String originalTitle;
  @JsonKey(name: 'original_title_romanised')
  String originalTitleRomanised;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'director')
  String director;
  @JsonKey(name: 'producer')
  String producer;
  @JsonKey(name: 'release_date')
  String releaseDate;
  @JsonKey(name: 'running_time')
  String runningTime;
  @JsonKey(name: 'rt_score')
  String rtScore;
  @JsonKey(name: 'people')
  List<String> people;
  @JsonKey(name: 'species')
  List<String> species;
  @JsonKey(name: 'locations')
  List<String> locations;
  @JsonKey(name: 'vehicles')
  List<String> vehicles;
  @JsonKey(name: 'url')
  String url;

  ExampleResponse(
        this.id,
        this.title,
        this.originalTitle,
        this.originalTitleRomanised,
        this.description,
        this.director,
        this.producer,
        this.releaseDate,
        this.runningTime,
        this.rtScore,
        this.people,
        this.species,
        this.locations,
        this.vehicles,
        this.url
  );

  factory ExampleResponse.fromJson(Map<String, dynamic> json) => _$ExampleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleResponseToJson(this);

}