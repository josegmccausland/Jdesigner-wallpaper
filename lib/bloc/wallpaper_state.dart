import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WallpaperState extends Equatable {}

class WallpaperInitialState extends WallpaperState {
  @override
  List<Object> get props => [];
}

class WallpaperLoadingState extends WallpaperState {
  @override
  List<Object> get props => [];
}

class WallpaperLoadedState extends WallpaperState {
  final data;

  WallpaperLoadedState({@required this.data});
  @override
  List<Object> get props => [data];
}

class WallpaperErrorState extends WallpaperState {
  final String error;

  WallpaperErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
