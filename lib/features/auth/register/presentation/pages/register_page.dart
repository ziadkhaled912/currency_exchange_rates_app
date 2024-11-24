import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/extensions/context.dart';
import 'package:currency_exchange/core/extensions/validators.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/presentation/widgets/app_button.dart';
import 'package:currency_exchange/core/presentation/widgets/app_snackbar.dart';
import 'package:currency_exchange/core/presentation/widgets/app_text_field.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const id = '/register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<RegisterCubit>(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        // appBar: const GenericAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 0),
            child: SingleChildScrollView(
              key: const Key('registerSingleChildScrollView'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Start Your Vacation Now',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 45),
                      const _Form(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Have Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        key: const Key('goToLoginButton'),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          'Login',
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
  final FocusNode _nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.user != current.user && current.user != null,
          listener: (context, state) {
            context
              ..showSnackBar(
                message: 'You Have Registered Successfully',
                state: SnackBarStates.success,
              )
              ..read<AuthCubit>().getCurrentUser()
              ..go(HomePage.id);
          },
        ),
        BlocListener<RegisterCubit, RegisterState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure && current.failure != null,
          listener: (context, state) {
            if (state.failure is AuthFailure) {
              final failure = state.failure! as AuthFailure;
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
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return AppTextField(
                  key: const Key('nameField'),
                  labelKey: 'Name',
                  hintKey: 'Enter your name',
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: _nameFocusNode,
                  validator: (value) {
                    if (state.name == null || !state.name!.isValidName()) {
                      return 'Please Enter Valid Name';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<RegisterCubit>().onNameChanged(value),
                );
              },
            ),
            const SizedBox(height: 15),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return AppTextField(
                  key: const Key('emailField'),
                  labelKey: 'Email',
                  hintKey: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  // focusNode: _nameFocusNode,
                  validator: (value) {
                    if (state.email == null || !state.email!.isValidEmail()) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<RegisterCubit>().onEmailChanged(value),
                );
              },
            ),
            const SizedBox(height: 15),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password ||
                  previous.isObscure != current.isObscure,
              builder: (context, state) {
                return AppTextField(
                  key: const Key('passwordField'),
                  labelKey: 'Password',
                  hintKey: 'Enter Your Password',
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: state.isObscure,
                  suffixIcon: InkWell(
                      onTap: () =>
                          context.read<RegisterCubit>().toggleObscure(),
                      child: Icon(
                        state.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      )),
                  // focusNode: _nameFocusNode,
                  validator: (value) {
                    if (state.password == null ||
                        state.password!.isNotValidPassword()) {
                      return 'Please Enter Valid Password';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      context.read<RegisterCubit>().onPasswordChanged(value),
                );
              },
            ),
            const SizedBox(height: 34),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return AppButton(
                  key: const Key('signUpButton'),
                  textKey: 'Sign Up',
                  isLoading: state.isLoading,
                  onPressed: !state.isFormValid
                      ? null
                      : () {
                          context
                              .read<RegisterCubit>()
                              .registerWithEmailAndPassword();
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
