import 'package:flutter/material.dart';
import 'package:rae3on_app_new_update/core/di.dart';
import 'package:rae3on_app_new_update/core/functions.dart';
import 'package:rae3on_app_new_update/view/widgets/view_account_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomePageCard extends StatelessWidget with CaculateFunctions {
  const MainHomePageCard({
    super.key,
    required this.widthPage,
  });

  final double widthPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      width: widthPage,

      // height: heightPage * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 5,
          color: Colors.deepPurple,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          ViewAccountWidget(
            lable: ": المجموع الكلي بالدينار",
            data: "${formatNumber(number: calcTotalDianr())}",
          ),
          ViewAccountWidget(
            lable: ": المجموع الكلي بالليرة",
            data: "${formatNumber(
              number: calcTotalLira(
                dinarPrice: num.parse(
                    config.get<SharedPreferences>().getString("dinarPrice")!),
              ),
            )}",
          ),
          ViewAccountWidget(
            lable: ": المجموع مع حسم النسبة بالدينار",
            data: "${formatNumber(
              number: calcTotalDianrWithDiscount(
                percent: num.parse(
                    config.get<SharedPreferences>().getString("percent")!),
              ),
            )}",
          ),
          ViewAccountWidget(
            lable: ": المجموع مع حسم النسبة بالليرة",
            data: "${formatNumber(
              number: calcTotalLiraWithDiscount(
                percent: num.parse(
                    config.get<SharedPreferences>().getString("percent")!),
                dinarPrice: num.parse(
                    config.get<SharedPreferences>().getString("dinarPrice")!),
              ),
            )}",
          ),
          ViewAccountWidget(
            lable: ": النسبة بالدينار",
            data: "${formatNumber(
              number: calcPercentInDinar(
                percent: num.parse(
                    config.get<SharedPreferences>().getString("percent")!),
              ),
            )}",
          ),
          ViewAccountWidget(
            lable: ": النسبة بالليرة",
            data: "${formatNumber(
              number: calcPercentInLira(
                percent: num.parse(
                    config.get<SharedPreferences>().getString("percent")!),
                dinarPrice: num.parse(
                    config.get<SharedPreferences>().getString("dinarPrice")!),
              ),
            )}",
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
