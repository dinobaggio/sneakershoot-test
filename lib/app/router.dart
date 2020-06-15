import 'package:auto_route/auto_route_annotations.dart';
import 'package:sneakershoottest/ui/views/detail_post/detail_post_view.dart';
import 'package:sneakershoottest/ui/views/home/home_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomeView homeViewRoute;

  DetailPostView detailPostView;
}
