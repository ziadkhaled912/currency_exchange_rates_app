import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/validators.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/presentation/widgets/app_button.dart';
import 'package:currency_exchange/core/presentation/widgets/app_snackbar.dart';
import 'package:currency_exchange/core/presentation/widgets/app_text_field.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:currency_exchange/features/auth/register/presentation/pages/register_page.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const id = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 36),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Enter Your Email and Password To Login',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const _Form(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have Account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        key: const Key('goToRegisterButton'),
                        onPressed: () {
                          context.push(RegisterPage.id);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final FocusNode _mobileFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.user != current.user && current.user != null,
          listener: (context, state) {
            context
              ..showSnackBar(
                message: 'Login Success',
                state: SnackBarStates.success,
              )
              ..read<AuthCubit>().getCurrentUser()
              ..go(HomePage.id);
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure && current.failure != null,
          listener: (context, state) {
            if (state.failure is AuthFailure) {
              final failure = state.failure! as AuthFailure;
              if (failure.type == AuthFailureType.userNotFound) {
                context.showSnackBar(
                  message: 'Invalid Email or Password',
                  state: SnackBarStates.error,
                );
                return;
              }
              context.showSnackBar(
                message: failure.errorMessage,
                state: SnackBarStates.error,
              );
              return;
            }
            context.showSnackBar(
              message: 'Unknown Error',
              state: SnackBarStates.error,
            );
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return AppTextField(
                  key: const Key('emailField'),
                  labelKey: 'Email',
                  hintKey: 'Enter Your Email',
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  // focusNode: _nameFocusNode,
                  validator: (value) {
                    if (value == null || !value.isValidEmail()) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<LoginCubit>().onEmailChanged(value),
                );
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password ||
                  previous.isObscure != current.isObscure,
              builder: (context, state) {
                return AppTextField(
                  key: const Key('passwordField'),
                  labelKey: 'Password',
                  hintKey: 'Enter Your Password',
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: state.isObscure,
                  suffixIcon: InkWell(
                    key: const Key('togglePasswordVisibility'),
                    onTap: () => context.read<LoginCubit>().toggleObscure(),
                    child: Icon(
                      state.isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  validator: (value) {
                    if (state.password == null ||
                        state.password!.isNotValidPassword()) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<LoginCubit>().onPasswordChanged(value),
                );
              },
            ),
            const SizedBox(height: 34),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.isFormValid != current.isFormValid ||
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                return AppButton(
                  key: const Key('loginButton'),
                  textKey: 'Login',
                  isLoading: state.isLoading,
                  onPressed: !state.isFormValid
                      ? null
                      : () async {
                          await context
                              .read<LoginCubit>()
                              .loginWithEmailAndPassword();
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
