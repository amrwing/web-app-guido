import 'package:andreabot_app/screens/screens.dart';
import 'package:andreabot_app/screens/user_information_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const LoginScreen(), routes: [
    GoRoute(
      path: "login_screen",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        path: "distritos_screen",
        builder: (context, state) => const DistritosScreen(),
        routes: [
          GoRoute(
              path: "responsables_por_distrito_screen",
              builder: (context, state) {
                final String dist = state.extra as String;
                return ResponsablesPorDistritoScreen(distrito: dist);
              },
              routes: [
                GoRoute(
                  path: "user_information_screen",
                  builder: (context, state) {
                    final Map<String, dynamic> dataUser =
                        state.extra as Map<String, dynamic>;
                    return UserInformationScreen(userData: dataUser);
                  },
                ),
              ])
        ]),
    GoRoute(
        path: "admin_home_screen",
        builder: (context, state) => const AdminHomeScreen(),
        routes: [
          GoRoute(
              path: "create_user_screen",
              builder: (context, state) => const CreateUserScreen(),
              routes: [
                GoRoute(
                  path: "create_user_screen_add",
                  builder: (context, state) => const CreateUserScreenAdd(),
                ),
                GoRoute(
                  path: "create_origen_screen_add",
                  builder: (context, state) => const CreateOrigenScreenAdd(),
                ),
                GoRoute(
                  path: "create_lider_screen_add",
                  builder: (context, state) => const CreateLiderScreenAdd(),
                ),
              ]),
          GoRoute(
              path: "responsables_de_red_screen",
              builder: (context, state) => const ResponsablesDeRedScreen(),
              routes: [
                //PASA CON PARAMETRO
                GoRoute(
                  path: "editar_usuario_screen",
                  builder: (context, state) {
                    final userData = state.extra;
                    return EditUserScreen(
                      userData: userData as Map<String, dynamic>,
                    );
                  },
                )
              ]),
          GoRoute(
            path: "supervisores_screen",
            builder: (context, state) => const SupervisoresScreen(),
          ),
          GoRoute(
              path: "export_networks",
              builder: (context, state) => const ExportNetworks())
        ]),
    GoRoute(
        path: "responsable_de_red",
        builder: (context, state) => const NetworkManager(),
        routes: [
          GoRoute(
            path: "datos_personales",
            builder: (context, state) => const PersonalInformation(),
          ),
          GoRoute(
            path: "cuestionario_captura",
            builder: (context, state) => const CaptureQuestionnaire(),
          ),
          GoRoute(
            path: "final_captura",
            builder: (context, state) => const EndCapture(),
          ),
        ])
  ]),
]);
