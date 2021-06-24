import 'package:bloc/bloc.dart';
import 'package:jdesigner/bloc/wallpaper_event.dart';
import 'package:jdesigner/bloc/wallpaper_state.dart';
import 'package:jdesigner/repository/wallpaper_repository.dart';
import 'package:meta/meta.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperRepository wallpaperRepository;
  WallpaperBloc({@required this.wallpaperRepository}) : super(null);
  WallpaperState get initialState => WallpaperInitialState();
  @override
  Stream<WallpaperState> mapEventToState(WallpaperEvent event) async* {
    if (event is FetchWallpaperEvent) {
      yield WallpaperLoadingState();
      try {
        var data = await wallpaperRepository.fetchWallpaper();
        yield WallpaperLoadedState(data: data);
      } catch (e) {
        var message = 'Something went wrong';
        yield WallpaperErrorState(error: message);
      }
    }
  }
}
