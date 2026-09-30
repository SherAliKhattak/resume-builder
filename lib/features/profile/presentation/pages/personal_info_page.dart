import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/widgets/app_screen.dart';
import '../../../../app/widgets/app_text_field.dart';
import '../../domain/models/profile_models.dart';
import '../cubit/personal_info_cubit.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _name = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  final _linkedin = TextEditingController();
  final _github = TextEditingController();
  final _portfolio = TextEditingController();
  bool _seeded = false;

  @override
  void dispose() {
    _name.dispose();
    _title.dispose();
    _email.dispose();
    _phone.dispose();
    _location.dispose();
    _linkedin.dispose();
    _github.dispose();
    _portfolio.dispose();
    super.dispose();
  }

  void _seed(PersonalInfo info) {
    if (_seeded) return;
    _seeded = true;
    _name.text = info.fullName;
    _title.text = info.title;
    _email.text = info.email;
    _phone.text = info.phone;
    _location.text = info.location;
    _linkedin.text = info.linkedin;
    _github.text = info.github;
    _portfolio.text = info.portfolio;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) => _seed(state.info),
      builder: (context, state) {
        _seed(state.info);
        final cubit = context.read<PersonalInfoCubit>();
        void update(PersonalInfo Function(PersonalInfo) change) {
          cubit.onChanged(change(state.info));
        }

        return AppScreen(
          title: 'Personal info',
          showSaved: state.saved,
          primaryLabel: 'Done',
          onPrimary: () async {
            await cubit.flushPending();
            if (context.mounted) context.pop();
          },
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              AppTextField(
                label: 'Name',
                hint: 'Jane Doe',
                controller: _name,
                errorText: state.nameError,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                onChanged: (value) =>
                    update((info) => info.copyWith(fullName: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Title',
                hint: 'Product designer',
                controller: _title,
                onChanged: (value) =>
                    update((info) => info.copyWith(title: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Email',
                hint: 'you@email.com',
                controller: _email,
                errorText: state.emailError,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textCapitalization: TextCapitalization.none,
                onChanged: (value) =>
                    update((info) => info.copyWith(email: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Phone',
                hint: '+1 555 010 0100',
                controller: _phone,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                textCapitalization: TextCapitalization.none,
                onChanged: (value) =>
                    update((info) => info.copyWith(phone: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Location',
                hint: 'Austin, TX',
                controller: _location,
                keyboardType: TextInputType.streetAddress,
                autofillHints: const [AutofillHints.addressCity],
                onChanged: (value) =>
                    update((info) => info.copyWith(location: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'LinkedIn',
                hint: 'linkedin.com/in/janedoe',
                controller: _linkedin,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                onChanged: (value) =>
                    update((info) => info.copyWith(linkedin: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'GitHub',
                hint: 'github.com/janedoe',
                controller: _github,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                onChanged: (value) =>
                    update((info) => info.copyWith(github: value)),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Portfolio',
                hint: 'janedoe.com',
                controller: _portfolio,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                onChanged: (value) =>
                    update((info) => info.copyWith(portfolio: value)),
              ),
            ],
          ),
        );
      },
    );
  }
}
