import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_dto.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';
import 'package:collection/collection.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class MockMainService extends MainService {
  final SharedStorage sharedStorage;

  MockMainService({required this.sharedStorage});

  @override
  Future<Either<ApiException, List<StartupDto>>> getStartups() async {
    await Future.delayed(const Duration(seconds: 2));
    return Right(_startups);
  }

  @override
  Future<Either<ApiException, StartupDto?>> getStartupDetails(
    String startupId,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    return Right(_startups.firstWhereOrNull((dto) => dto.id == startupId));
  }

  final _startups = [
    StartupDto(
      id: 'startup_1',
      name: 'EcoPack AI',
      description:
          'Платформа на базе ИИ, которая разрабатывает устойчивые упаковочные решения для бизнеса электронной коммерции, снижая отходы пластика за счет оптимизации использования материалов и предложения биоразлагаемых альтернатив на основе размеров продукта и потребностей в доставке.',
      imageUrl:
          'https://www.iberdrola.com/documents/20125/40792/Startups_746x419.jpg/9338c82a-c190-ebdc-e695-aab7328030f5?t=1627631387830',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
    ),
    StartupDto(
      id: 'startup_2',
      name: 'Mindful Connect',
      description:
          'Приложение для телемедицины, соединяющее пользователей с лицензированными терапевтами через видеозвонки, с интеграцией ИИ-чатботов для начальной оценки и отслеживания настроения, предоставляющее персонализированные планы поддержки психического здоровья.',
      imageUrl:
          'https://www.iberdrola.com/documents/20125/40792/Startups_746x419.jpg/9338c82a-c190-ebdc-e695-aab7328030f5?t=1627631387830',
      createdAt: DateTime.now().subtract(Duration(days: 20)),
    ),
    StartupDto(
      id: 'startup_3',
      name: 'FinWise Advisor',
      description:
          'Инструмент для личных финансов, использующий машинное обучение для анализа привычек расходов пользователя, прогнозирования будущих затрат и предложения персонализированных инвестиционных советов, с интеграцией API банков для синхронизации данных в реальном времени.',
      imageUrl:
          'https://www.iberdrola.com/documents/20125/40792/Startups_746x419.jpg/9338c82a-c190-ebdc-e695-aab7328030f5?t=1627631387830',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    StartupDto(
      id: 'startup_4',
      name: 'Urban Farm Tech',
      description:
          'Системы вертикального земледелия на базе IoT для городских жителей, позволяющие удаленно мониторить гидропонные сады через мобильное приложение, с автоматизированной подачей питательных веществ и алгоритмами оптимизации урожая.',
      imageUrl:
          'https://www.iberdrola.com/documents/20125/40792/Startups_746x419.jpg/9338c82a-c190-ebdc-e695-aab7328030f5?t=1627631387830',
      createdAt: DateTime.now().subtract(Duration(days: 15)),
    ),
    StartupDto(
      id: 'startup_5',
      name: 'LangBridge Edu',
      description:
          'Иммерсивная платформа для изучения языков с использованием VR и ИИ для симуляции реальных разговоров, адаптирующая уровень сложности на основе прогресса пользователя и предоставляющая культурный контекст для лучшего запоминания.',
      imageUrl:
          'https://www.iberdrola.com/documents/20125/40792/Startups_746x419.jpg/9338c82a-c190-ebdc-e695-aab7328030f5?t=1627631387830',
      createdAt: DateTime.now().subtract(Duration(days: 8)),
    ),
  ];

  @override
  Future<Either<ApiException, List<String>?>> getFavoriteIds() async {
    return Right(await sharedStorage.getFavoriteIds());
  }
}
