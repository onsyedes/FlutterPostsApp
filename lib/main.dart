import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/app_theme.dart';
import 'package:posts/dependency_injection.dart' as di ;
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_bloc.dart';

import 'core/app_routing.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
           create:(_)=> di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostsBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          title: "Posts App",
          initialRoute: '/',
         onGenerateRoute: AppRouter.onGenerateRoute,
         ),
    );
  }
}
