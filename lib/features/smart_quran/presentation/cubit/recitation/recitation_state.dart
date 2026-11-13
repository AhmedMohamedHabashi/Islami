part of 'recitation_cubit.dart';

sealed class RecitationState extends Equatable {
  const RecitationState();

  @override
  List<Object?> get props => [];
}

final class RecitationInitial extends RecitationState {
  const RecitationInitial();
}

final class RecitationLoading extends RecitationState {
  const RecitationLoading();
}

final class RecitationError extends RecitationState {
  final String message;

  const RecitationError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RecitationLoaded extends RecitationState {
  final List<Ayah> ayahs;
  final int currentAyahIndex;

  const RecitationLoaded({required this.ayahs, this.currentAyahIndex = 0});

  Ayah? get currentAyah {
    if (ayahs.isEmpty) return null;
    return ayahs[currentAyahIndex];
  }

  bool get hasNextAyah => currentAyahIndex < ayahs.length - 1;

  bool get hasPreviousAyah => currentAyahIndex > 0;

  @override
  List<Object?> get props => [ayahs, currentAyahIndex];
}
