import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomListTile extends StatelessWidget {
  final bool selected;
  final bool selectable;
  final Widget? leading;
  final Widget? topCorner;
  final Widget? trailing;
  final Widget? title;
  final Widget? subTitle1;
  final Widget? subTitle2;
  final Function()? onPress;
  final double? elevation;
  final Color? elevationColor;
  final int? leadingFlex;
  final int? titleFlex;
  final double? leadingHeight;
  final double? leadingWidth;
  final double? trailingHeight;
  final double? trailingWidth;
  final double? trailingMargin;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
  final BorderRadius? borderRadius;
  final TextDirection? textDirection;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;


  const CustomListTile({Key? key, this.leading, this.trailing, this.title, this.subTitle1, this.onPress, this.elevation, this.padding, this.borderRadius, this.textDirection, this.titlePadding, this.titleTextStyle, this.subTitleTextStyle, this.elevationColor, this.leadingHeight, this.leadingWidth, this.trailingHeight, this.trailingWidth, this.subTitle2, this.selected = false, this.selectable = true, this.leadingFlex, this.titleFlex, this.trailingMargin, this.topCorner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextDirection? defaultTextDirection = Directionality.of(context);
    if(textDirection != null) defaultTextDirection = textDirection;

    return selectable
        ? Directionality(
      textDirection:  defaultTextDirection ?? TextDirection.ltr,
      child: InkWell(
        onTap: onPress ?? (){},
        child: Padding(
          padding: padding ?? EdgeInsets.all(8.0),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: selected ? kPrimaryColor : Colors.transparent)
            ),
            elevation: elevation ?? 1,
            shadowColor: elevationColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(leading != null)
                  Expanded(
                  flex: leadingFlex ?? 2,
                  child: Stack(
                    alignment: defaultTextDirection == TextDirection.ltr ? Alignment.bottomRight : Alignment.bottomLeft,
                    children: [

                      Container(
                        padding: EdgeInsets.all(kDefaultPadding/4),
                        constraints: BoxConstraints(
                          maxHeight: leadingHeight ?? 100,
                          minHeight: leadingHeight ?? 50,
                        ),
                        child: ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.circular(16),
                        child: leading!,
              ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                        CircleAvatar(radius: 10.0, backgroundColor: kPrimaryColorBrighter),
                        if(selected) Icon(Icons.check_circle, size: 18,),
                      ],
                      ),


                    ],
                  ),
                ),
                Expanded(
                  flex: titleFlex ?? 4,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Padding(
                        padding: titlePadding ?? EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(title != null) DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16),
                              child: Row(
                                children: [
                                  title!,
                                ],
                              ),
                            ),

                            if(subTitle1 != null) DefaultTextStyle(
                              style: subTitleTextStyle ?? TextStyle( color: kBlackColor.withOpacity(0.66)),
                              child: Row(
                                children: [
                                  Expanded(child: subTitle1!),
                                ],
                              ),
                            ),
                            if(subTitle2 != null) DefaultTextStyle(
                              style: subTitleTextStyle ?? TextStyle( color: kBlackColor.withOpacity(0.66)),
                              child: Row(
                                children: [
                                  Expanded(child: subTitle2!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(trailing != null)
                        defaultTextDirection == TextDirection.rtl
                        ? Positioned(
                        left: trailingMargin ?? 16,
                          // top: 16,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: trailing!),
                        )
                      : Positioned(
                          right: trailingMargin ?? 16,
                          // top: 16,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: trailing!),
                        ),

                      if(topCorner != null)
                        defaultTextDirection == TextDirection.rtl
                        ? Positioned(
                        left: 0,
                          top: 0,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: topCorner!),
                        )
                      : Positioned(
                          right: 0,
                          top: 0,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: topCorner!),
                        ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    )
    : Directionality(
      textDirection:  defaultTextDirection ?? TextDirection.ltr,
      child: GestureDetector(
        onTap: onPress ?? (){},
        child: Padding(
          padding: padding ?? EdgeInsets.all(8.0),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.transparent)
            ),
            elevation: elevation ?? 1,
            shadowColor: elevationColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(leading != null) Expanded(
                  flex: leadingFlex ?? 2,
                  child: Stack(
                    alignment: defaultTextDirection == TextDirection.ltr ? Alignment.bottomRight : Alignment.bottomCenter,
                    children: [

                      Container(
                        padding: EdgeInsets.all(kDefaultPadding/4),
                        // height: leadingHeight ?? 70,
                        constraints: BoxConstraints(
                          // maxHeight: leadingHeight ?? 100,
                          minHeight: leadingHeight ?? 50,
                        ),
                        // height: leadingHeight ?? 100,
                        child: ClipRRect(
                          borderRadius: borderRadius ?? BorderRadius.circular(16),
                          child: leading!,
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  flex: titleFlex ?? 4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: titlePadding ?? EdgeInsets.all(12.0),
                        child: Container(
                          height: leadingHeight != null ? leadingHeight!/2 +16 : 70,
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(title != null) Expanded(
                                child: DefaultTextStyle(
                                  style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16),
                                  child: Row(
                                    children: [
                                      title!,
                                    ],
                                  ),
                                ),
                              ),

                              if(subTitle1 != null) DefaultTextStyle(
                                style: subTitleTextStyle ?? TextStyle( color: kBlackColor.withOpacity(0.66)),
                                child: Row(
                                  children: [
                                    Expanded(child: subTitle1!),
                                  ],
                                ),
                              ),
                              if(subTitle2 != null) DefaultTextStyle(
                                style: subTitleTextStyle ?? TextStyle( color: kBlackColor.withOpacity(0.66)),
                                child: Row(
                                  children: [
                                    Expanded(child: subTitle2!),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if(trailing != null)
                        defaultTextDirection == TextDirection.rtl
                            ? Positioned(
                          left: trailingMargin ?? 16,
                          // top: 16,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: trailing!),
                        )
                            : Positioned(
                          right: trailingMargin ?? 16,
                          // top: 16,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: trailing!),
                        ),
                      if(topCorner != null)
                        defaultTextDirection == TextDirection.rtl
                            ? Positioned(
                          left: 0,
                          top: 0,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: topCorner!),
                        )
                            : Positioned(
                          right: 0,
                          top: 0,
                          child: DefaultTextStyle(
                              style: titleTextStyle ?? TextStyle( color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold),
                              child: topCorner!),
                        ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
