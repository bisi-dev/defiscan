import 'package:defiscan/core/app_core.dart';

import '../../../../shared/theme/app_decoration.dart';
import 'shimmer.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        10,
        (index) => Container(
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          child: Shimmer.fromColors(
            baseColor:
                Theme.of(context).colorScheme.surfaceTint.withOpacity(0.1),
            highlightColor:
                Theme.of(context).colorScheme.surfaceTint.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                roundContainer(child: const SizedBox(height: 10.0, width: 50)),
                const SizedBox(height: 20),
                loadingTransactionContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingTransactionContent() {
    return Builder(builder: (context) {
      final width = MediaQuery.of(context).size.width;
      return Column(
        children: [
          Row(
            children: [
              const CircleAvatar(maxRadius: 20),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roundContainer(
                      child: SizedBox(height: 20.0, width: width * 0.55))
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  roundContainer(
                      child: SizedBox(height: 10.0, width: width * 0.10)),
                  const SizedBox(height: 8),
                  roundContainer(
                    child: SizedBox(height: 10.0, width: width * 0.075),
                  )
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget roundContainer({Widget? child}) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: borderRadius8,
        color: AppColor.kWhite,
      ),
      child: child,
    );
  }
}
