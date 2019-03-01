import 'package:flutter/material.dart';
class RatingView extends StatelessWidget {
  final  rating;
  final iconSize;
  final fontSize;
  RatingView({Key key, this.rating,this.iconSize,this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize * 10,
      height: iconSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Expanded(
          //   flex: 1,
          //   child: Text('豆瓣评分:',textAlign: TextAlign.center,),
          // ),
          Expanded(
            flex:1,
            child: 
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context,index){
                  double current_star = (index+1) * 2.0;
                  if(rating > current_star){
                    return Icon(Icons.star,size: iconSize,color: Colors.black54,);
                  }else if(rating > current_star - 1.0){
                    return Icon(Icons.star_half,size: iconSize,color: Colors.black54,);
                  }else{
                    return Icon(Icons.star_border,size: iconSize,color: Colors.black54,);
                  }
                },
              ),
          ),
          Expanded(
            flex: 1,
            child: 
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child:Text('${rating}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black54,fontSize: fontSize),
                    ),
              ),
          ),
        ],
      ),
    );
  }
}