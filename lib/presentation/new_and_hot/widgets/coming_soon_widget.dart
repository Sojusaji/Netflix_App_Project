import 'package:flutter/material.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/custom_button_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            children: const [
              Text(
                "FEB",
                style: TextStyle(
                  fontSize: 16,
                  color: kGreyColor,
                ),
              ),
              Text("11",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: kWhiteColor,
                  ))
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoWidget(),
              Row(
                children: const [
                  Text(
                    'TallGirl2',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CustomButtonWidget(
                    icon: Icons.notifications_none,
                    title: 'Remind Me',
                    fontsize: 16,
                    iconsize: 20,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomButtonWidget(
                    icon: Icons.info,
                    title: 'Info',
                    fontsize: 16,
                    iconsize: 20,
                  ),
                  kwidth,
                ],
              ),
              kHeight,
              const Text("coming on friday"),
              kHeight,
              const Text(
                "Tall Girl 2",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeight,
              const Text(
                "Landing the lead in the school musical is a\ndream come true for jodi, until the pressure\nsends her confidence - and her relationship--\ninto a tailspain",
                style: TextStyle(color: kGreyColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            newAndHotTempImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 22,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
                color: kWhiteColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
