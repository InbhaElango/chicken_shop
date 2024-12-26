// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'home_page_text_field.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    ),
  );
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  double anime_opacity = 0.0;
  Color scaffoldColor =
      const Color.fromARGB(255, 182, 111, 226); // Initial violet color

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        anime_opacity = 1.0;
        scaffoldColor =
            Colors.purple.shade900; // Change color to pink after the delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: anime_opacity, // Fixed here
      duration: const Duration(seconds: 2),
      child: AnimatedContainer(
        duration: const Duration(seconds: 2), // Color change duration
        color: scaffoldColor, // Animated color change
        curve: Curves.easeInOut,
        child: chickenInputScreen(context),
      ),
    );
  }
}

Widget chickenInputScreen(BuildContext context) {
  final TextEditingController fleshController = TextEditingController();
  final TextEditingController legsController = TextEditingController();
  final TextEditingController wingsController = TextEditingController();

  Map<String, int> stock = {"flesh": 0, "legs": 0, "wings": 0};
  Map<String, int> partsPerChicken = {"flesh": 1, "legs": 2, "wings": 2};
  int totalChickensKilled = 0;

  // Function to process the order
  Map<String, dynamic> processOrder(Map<String, int> order) {
    int chickensKilled = 0;

    for (var part in order.keys) {
      if (stock[part]! < order[part]!) {
        int needed = order[part]! - stock[part]!;
        int chickensToKill = (needed / partsPerChicken[part]!).ceil();
        chickensKilled += chickensToKill;

        // Add stock by killing chickens
        for (var p in partsPerChicken.keys) {
          stock[p] = stock[p]! + (partsPerChicken[p]! * chickensToKill);
        }
      }
    }

    totalChickensKilled += chickensKilled;

    // Deduct the order
    for (var part in order.keys) {
      stock[part] = stock[part]! - order[part]!;
    }

    return {
      "status": "success",
      "chickensKilled": chickensKilled,
      "remainingStock": stock,
    };
  }

  return Scaffold(
    backgroundColor:
        Colors.transparent, // Making the scaffold background transparent
    appBar: PreferredSize(
      preferredSize:
          const Size.fromHeight(150.0), // Adjust the height of the AppBar
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
        flexibleSpace: Center(
          child: Container(
            width: 120, // Avatar size
            height: 120,
            // Avatar size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2), // Glassy effect
              border: Border.all(
                color: Colors.white
                    .withOpacity(0.5), // Border to enhance the glass effect
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxITEBUSEhIVFRUXFxoXEhcYFx0aFhgYFxcXGhgdFRcYHSggGh0lGxgXITEhJSkrLi4uFx8zODMsNygtLisBCgoKDg0OGxAQGy0mICYtLS0yLS0tLS8tMi0tLS0tLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIASsAqAMBEQACEQEDEQH/xAAbAAEAAQUBAAAAAAAAAAAAAAAABgECAwQFB//EADoQAAEDAgMFBgMHBAIDAAAAAAEAAhEDIQQSMQVBUWFxBhMigZGhMrHBByNCUmLR8HKi4fGCkhRDwv/EABoBAQACAwEAAAAAAAAAAAAAAAABBAIDBQb/xAA1EQACAgECAwUHAwMFAQAAAAAAAQIDEQQhEjFBBRMiUWFxgZGhscHRMuHwFCPxFTNCUoIk/9oADAMBAAIRAxEAPwDxBWDEIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAEAQBAEAQBAEAQBAEAQBAAEAIQBAEBVAUQBAEAQBAEAQBAEAQBAAEAQBAEAQBAEBe+nAaZBkTA1FyIdztPQhAWIAgCAqW2BkdN46oCiAIAgCAISEICAIAgCAIAgCAICqEmWnhnOEhshTgwc4p4bLX0XDVpHkoJUk+TN3Zuze+Y/K77xsFrDo8G1juMwOeYLTZbwSWVsWqdO7Yvh5rp5mkWDLM+KSC2DpxnrIjktmdzRhY9SwLIgohBUFECiABAEBc1hOnM+QEn2UN4MlFvZFwiDI1+E9NUJWMPKLCFOTHGAFIKKCAgCAIAgL6dOZuBAm5idLDib6KG8GUY5K4eiXuDQQCbCTA9Uk+FZMq4OclFdTu4LY9Zhh2WHfq/wtcdRHJYu7JuksrGV6mbEbMrt/DPQg+0ytnfR8yk+z71/xz7DWwbg2oS6GuAJhwLc43tsNSNJ3jjCTjGawYQtt01ilFPPkYNr4fO91djHd251zvDoBeJFiZk9FhXHgjwt7r6G2y5Tm5JYyaO0ML3by0GWm7HfmadDHseYKsW1Sqm4S/mTXVZxxyYadQiYi4IuAbEQddDz1C1mbWS2N6YBQICrom2m6dfNAAN/8/lkJL6ccD5br71D5GcMZ3JHj9hNcO9Esa5xbm+KmHcDfwHQ31GipLUOMnF7vn64+53NZ2fU5twfD6dDWpdnKzXgupmowEh4YfFGhgGDI1HRTLWQcdnh+pTXZt0JJyjmPocjEYctqFgkkEgSC0nh4TcW3K1CfFFSOfOtqbivwYCszWVzGI3a+kx8ygKIAgCAuY0nRSot8iS7uncCpcJeQJNgsd3jWsLXNeG6uMipG8WEHldUrKnB56Hc0WplZHgse/Tbmvyd/D0W1RlpVJeB8LwGuPIGSCfQK7HTxnXxRkn6df3KN99lEs2R281v9jWxeIbUAbUptJFiYueo48wqSqcHlMv8AfwvilOKZ039kMK+gyrRe9hc3xD4w1wsQQbm/ByqrW3Qm4yw/ka/9Hqui+BtfNEc2l2dqkhlQizXNoPHwOdOYNJiQT4rHebK89X3iUlzWMrrj9jmw7OlRa67duLOH0cvL3kRI/wAreaC1CAgCABAbWKqMcGljS12WKg/CSNHN6jUceq1wjJN5eV0N05QaTisPG/5JNSOdzRJDamXMATDgPEM17qvb4U5dUeujGOosrzyeCV4aGiZiPouNKPFsd+3CWMbHUq4HDY6nkrsl0Q2oIFRvNro9jIVVzu0k+Kt+7oec1ukhameRdotjPwmIfQeQ7Ldrho9p+Fw4Tw3EEL0+l1EdRUrInlLqpVT4ZHNVg1BAEABQF9J8GVlGXC8knTp53xTaXETIbm8MxcgEwDAVp4XiEpcMcs6WzdhYrEeLD0ninNnPqDKCNTmhsweAsql+tpp2se/kWaKL7EuH48kS/Cdj6zwO9qUhUG9gc6eeguuY+06U9ovHwO4qJyhi3GTov7HVA05MQASIe1zHNa4ep/wso6+ufT5lSeh3TTyZtjbOxFGaVRksdcPYczQ7mNRItpFhzVbUShJ8ae/2LumnKt4kimIosAeHtLg6AW/hN75hqOII0I5yC8WJR5nQvqV8eFpOL5/seedrezncu7xh+6cC5pOtvwn9QnzF+K6NOo7xb8+v5PIajRy01jg34eaf29pFirBXKi27X/SnkQWqAAgKhCSQ7GqhzchqtY9l2TJBGtnNnQ/RV7c/9cpnf0GpzBVuWJR5Et2YX16UxlgxO5xH5OIVSGm/uYPT06rv68tYfy9x29mMAESQea06vS5eDVOtpkH+0d01KZOoDmnjAII9yfVbOzI8ClE4Pb9MYqua65+xDgV1TzZRAEBdSaCQCQ0TcmYHMxdQ3hGUUm8Nlqkg3MLdpkGBviQt9U8rhIz06k7+zPbOSo7CkmKhzUjwfF28swAjmOa5Pa+l40rYrlz9n7HW7N1CjLu5deXtPU9l40tPdvEA/C76O/deYu08peKJ1dRUpeOPwO1mO+VXi5Io4XQw4jAsdceE8R/9NV6nWSW0jKF047czmY3ZgqeF4AfucNHjnxPur9cljihy8i1VqHDePLy8iK4/Ypex+GqiJEtO4EfC4fzQkLdG7gkrF/EbNXTDV0tfD0Z43tWk9lTuXiDSlml/ic6/G7jfhC7MWmuJcmeS4HBtPn19vI0wFkSUQgIC4dUJO12V2X/5FdocSKbbvIsYEmJHGdea1W2Rgtzo9m6SWos9Fz/B6biqQZGWMggCIEDdbhCr02Rck8ns65YSWMFKe0mUCahpCqR+EugDnoQtupw/BkyvqnZHClg4fbrtcK2HNN+DYWu+B/eeKm8aEDII9biQufp+zZVW97Gx+zHyPNdr6eVEFlZi+vkzzNdg86CgKgIChCAvo0i4wP8AA6olkhtLmdIYlwY2mXuc1p8LS6KYJJvlmN5uVsjFRfF1NKhmfEkk316/E3cUQ3LkqhztTkBDWEREO3nmArFcnYm3HC9S3bTCvHDNN+nJe/qej9le0jcSO4quBrtFnNkNqiNWyAQ7iIG8i2nndbopUvjgvC/kdzQ65T8Env8AUluD2i+mcr2uLN29zf3C5dmnU948y5Zp4z3jzO7h6rXiQ6R0n1G5UpKUXhooTi4vDRkqUg4ZT6j5jmt9UuHdbGKk08o5GMwxJ7upw+7qR8+fFW5JzjxRLtViXjh70eWfaJsTLWbXLfE2DUH5msInr4YPqt/Z+peHWzbqdJXdWtTBZcHlrzj+V9DzirRhocPhLnAf8Y+jgu3GW+Op5iyrEVNcm2l7v8mJ0blmai+q8ucXQBNyGiAOgFgEISwsFrWkmBqdOpRmSTk8I9Y7EbFLWQ0STDf6nuIn6ey4uqu4p4PZ6auOkpUX5ZbOvtGk1uU1GwDnaTrEBzW9fFCqVNyyo80WVNyj4X5fz4EfNSA2WuIdZsCZ3Rz3+nJddWxlHEuaLq1EUsSIX2lxhLu6AhrTIO90ix6QfdWq5qUU0eU7c1s7J9xjCi/jtzOI0wdAfkth58tQBAZKNIuMDz5BSlkiUlFZZ0WUvwtBj3PVbUkkaM8T9TfZs4lrRUcGtbJAaBmJJuXHedBcmANFXlqIp7bnSp7Ltk+Kfhz58/h0Nij3VP4aYPN3iPpp7LGN88+hfjo6K+mX6khwW1acNzN7oT8TWyLROUSL3HrqtVlNjfPJ067qYw2gk/kSDAdpWuOWpDm/heILo3Z2j6e6oW6LG8fgbotc4te5nZpE/HSNuLfrHyVRwX6Zm1uMliR0aO1Ko1APMj9k/pK+hWlpa3yZdiMbVeIhsdDI6SVnXTGDymyIUVwedzmbdwLsTTaBGdhtI1BGh9lrtxBueC3pLo6ebz+lnhu2qXdONGIAeXt6ODbeUR5Lt6eXGlP0wec7Tr/p7Hp1yUnJexpfg5giD7KycoBCTrdmcLnrgnRviP0/nJaNRPhgzp9k0d5qE/Lf8HtGyqww4owJLSHu9JA6XB9V59vLyejtr75SXnsb7AzvMP3oBa5zc06eIuF+Vlp083lmixSddqhzxt7iP4fDZe8ptPiw9cmkTeMtTwH/ALAA9TwV+bxLi80b3/drSnynHf3r/JCPtOpUX1mYmiMoqN+9Zvp1JOZp8w49CFe0M+cfeee12mtrqg7eabjnzS/S/hle4hJXQOSUhAVI/nBAbtOq2m2NXHXgORKyTwapRc36GF+IfZ2aLyAN0b1i9+Zsr8DzHmup2sFtEVBDjD/Y9OfJVZV8PLkd6jWK5cMtpfU2cTRc2WmLaxB/uEj0KRmmjOdTzkzUBSaIOaq4iwEta1x0FxmdB4R9VdhZVGHibz8l7yo4XylhLC+LZvUNjfnmfytEnzP7LVK/P6fidWvRY/3Pgjq7Gwr21Yw9KoHj4g0u0/WNI6haLeFxzY1g3Lua3y+LJjhnYmPvMK4822PpJn2VJwp/4TJc63+mfxNmniaRMEljuD2kH9k7qeMrf2E8M8ZSz7DqUmNIDmOEjgZHkfoq1kXykipKUk+GS2PFPtW2b3WLDogPzOb0LpjyLiPRX+z34HEq9stWRqs64cX7uXyZCF0DhFUBLOx1CGOf+YwOgH7kqhrHyR6jsKvFbn5v6Ho2y9qMPxCPHJnc1rIaP+xcVxb6ZKDkvL55OlbXJ7r+bm3VirTYwmPCQ3qxjz81UhLu9/5uxF93Jv1+rRzaTw1tKvr3jXNrjfOYgu95XSgpPiT6Pb2G1xcnKHk1gjfbzBfdPdxDanmCASPIlb9HZ/cS9xU7TgrNHP0afwf4PN12zxYQBAEBVCTPgcG6q/KyNCSSQ1rWjUucbABQ2ka7LFXHLNzBbVNMw/71osBMf3ETCwdcXudPS6+Vf+4nJeWfvub+G7QMa/MKZYdwHiA/7Qf9rTZRxLHQu1dqwjPiUcfP6ncw3aKn+KWcxIPpr7rCumyO3NHRXaVM1mWxu4TaeHLw5tdwduOV4PqFb7qbW6TXuMY6nTSfP5HfpbaO7FVT5v8A3Wv+nj/0RcjCmXJL4CrjpvL3ni4n5mVnGrCwsIswjFLEVgpWpPc2RWojgJcCPVuqjOHhxZhZN4xwv5EC7X1qtRoFRxd3ZME3IBifKwK3qqKTcUec7Tc5RSfRkUGmqwOKZsJhH1HZWCTv4AcSdywlNRWWbqNPZfLhrWT0nYGxu5pMZUBzRJkEC97A3Oq5t0+8eUe10GmVNKhnL9DedSbn8IjeQFXvTUMI6DpTjll2Oe8NGVxgSRGokQfZVNNXGc1FrmVJ0vmczZO1c/gJhwmODp+th6L0k9JwLKWxhRq42vhlz+p0u1tNj8G97LA03Et/K9o8YA3C8+a4cISq1Ci/M1XqS09sJc0n710PHyvQHhzI5gyg5pJJlsG0REnQzfTghBjQBAEAQF8jKbGZEGbRebR0vO5RvkyysepsYMgNc4wCI3+IzaGt37yT/hQ3hpGyuSiuRlotzuAbJJsBGqydiiss2wi7ZKMc5ZJ9jbKax4zN75+9ocWsHpc9TZVZapveMuFHdo7OhU05+KXyX5J3sbYtSqQRkos5XA95Pkoetqjs8tl2eo7pYS38iQVezlCm2X4gu4QRfoA0lbYXOfKJWh2hdY8Ric19DDGRLxzlrvXwj5re4T6F3jvSy8EK7YbIyDOwB1M2LxOp/M0/Dy4rZS3ykcXWX13NwSw/5yIDs7Z7qtTILAfG7cAPrwCr2zUEcvSaSeos4Fy6vyRPOzuDptPhbDGR/wAnHTMd+hPoqFvFJb82esoqhWu7qWEvn7SfbZxDS4NcJDrdCN456eiqQr4IZjzROlqlwtrmtyJVWuZULTdwMdenVZpqceI7sZRnWn0ZvY3DPbS71zS1ul9ZPLXcmijCV2IlWu+tz4M+pDtq4YNIc3R3seS9ZpnxLDOL2rplVNWQ5S+pkqbTc7DVWPBJFN0OH9J+L91z9fo1lSj0Zq/1HOnnCznwtJ+4ghWJ5QqhBRAXMibzF9OlvdAWoC5pAMwCAdDoesIChQkNKBPDOhgNrvpvLw1rpGW40HBsER/haLaFYsNl/S9oWUT40k+m/T2HWwu33vdDKL8x3U3mfQN0WlaKXJPPuL0u3oJZnDH/AKOthNrucS3I+QYcC4WIsQTCyVEltt8C/R2nVOKljn6kl2NiKxtSa5w3tAL2+doBWfC4PxSwWpaiqzdrHrk7TqmUxVogO4EkH03K9VFtZcieB2RzGexztt7cY2k9jaTBLTmtmPLW0zG5WoKuOZvfBRfZ9cW7Z7teZCsJQFOlYQX+N3G+g9PmVxJy7y1s3aalaej1lu/sdrADLQbxcS4+sD2A9VMVmTfuL2kj4ckwGEdiKbHtIAmXk7jFwBvuubK6NTcXzMI3qiUovn0L8aKdJ8tAzFolx10i3DTcqEVOxb8vIUcdsfE9s8jFin58PUBv8J/uA+RV7s6PBdsbIQUbo+/6EL2nhJZl4OF+V163Ty8WTHtmShpF7V9zmbRqNZhqsWGUgdXW+qat+E8lPaDciEgLnlAohBUlAUQBAEBe+oTE7hAsNJJ3a6lQlgycm+ZaSpMQBZMA6GErPLcjSW0xcgRJPMgSfot1M7FlReM8zVbGvi4sbky7EVsG22Ip1ar5llMACk1o3vcXDN5+60amjUzfBQ0l1b5nQ7PcZPg5yJfjO2Vu7ohtJot4LujkbBvl6rVDSVUc3xS82ehq08c77/QxYXDPeM9Qmkw3B1qPn8oPzPvorFfFZyL0rlDwRWZfJe38GHtrhqTcG1lKmGEO7yo43eRdjWl2t3OcYsPuzwUaizgarzzOYp222TcpZSWPTPp7CMbTEHy+So1nS1KJNszZefIDZjGtDjxOUWHNapajgg8c3k2Qs7upJczu43aPdZWNAygXbu5ef7rlKvvG5PmYU6bvMyfPzMLsFWxVTPQpPLIAzGGtnf4iY9FZopko4NkdRTpIcNslnfZbv5G7tHYtXDYd3e5fE2waZiHM1tzW6iDrvjnqV6NdXqblwZ2fX2Mh3aLwNa3QkZnfIeglej00ubKvatjsnGHRbkC27jszQ1uk+sb/AJLHUTyzzOovVk+GPJfNnDVY0hAEAQFQ5CSiEBAX0qRdMRYEmSBYaxJv01QN4LEBmpVHBpgwJ9z7pxYHdprLO/hqZp0wPxmC8n2Hl85V1p1146vn+Dv6en+nqSX6nz/BMuzWBZWcHtYe6oxmJ+KrUNwDwFpjh/UqVVE23xvn9Ddfq1BRjXzf06v8EmxVdlIHEYl2vwNHxPI3MG4c9ArU5xqjwxK8dW7P7Gn3fWXRHnm3NrPrvc55iTIaPhbAhoHQfMneVSay+IuKMaa+CP8Al+Zt1WGqGZbl4AHV0D5qnxcGc9Dp2NTgp+h6nT2aWtAbAA0/U7kBrdcD+o4nhbtnP79df8I1X7Pp0SX1Yq1DeCPA3y/Eetvmu9ptLhJyN8b7L1ww8Mfm/wAF2E2nUdUsSrk4pIi3S1xhyN7tnjPuqLHCTqekgj3YuVJ//THHRN/HYpdnQ4bJzXs+X7njHbLHOq4gsB8LQA7hNyZ6T7LvabaHEzlds6hu7gT2W3vIdiquZ1tBYdFhJ8Tyc2EcLcwrEyBQBAEAQBAEAQkqSgM+z6eaqxvFzQfVZ1R4pxXqjbp48VsYvzRJMfjaLCZdmPBtz5nQLqX2Uxe7y/JHodTqtPW93l+SNzCfaAaOFbQo0Gh0uc9zrglxsQ0fEQ0NFzFtFQnqG/0rB5TVKzU6l2SliGy4V93+DW/82rXacRUeX+IMLnG5ME5WjcANwgCVRlNcfC+fM9JolGFP9tYj9zFXxTW0iBd77E/lbw6n5LfFZNtt8YVtL9T+S/LJL9mpFWrkd/6gXjobexcfZcbth93DK67G3S6pOh1vmnt7D1Tv4Gfyb9Sq/Zejwu9l7jDu+J8PxOBi5e5d9PB1KsQjsdPYmDvmNgLk8AtF01FZfIpay7bC5kY7bdomZ3OLgAPCyeVvaI6grnaWMrG7Mc/p0NmnjVpq07ZJdf4jyDae0M7jlkAm5Oruq7Kbxg8pq7I3XOcVhdP39TnkqTQCFAKIAgCAICu7mhICAohBe18AiAZi51EGbKMbmSe2CxSQX0nwZgHhOnoi2IaysFHuJMkySgSSWxs08dUAa2Za2YbuuZJ68+Sw4IpuXVliGonFJZ2XQ2HVc4tflvWyDxzLMrFYtj0H7MGZBUdHie0O/wCIJDfqfMLz/bc8uOOSZ09DViGX1+h6Y6g5wHTVdemLjBL0Nqmossbg2gy4pZbCteJ4MndJrCIv2z7cUsLTNKjldU37w08+Lv0jTUqpGuWreZLEPLqznanU908reXyR4ljcU+rUL3mSfbkF0YxUVhHJssnZLim8s11kawSgCAIAgCAIAgCAIAgMge3JGXxE/FwHAD6qMPOTLK4cYMakxLmoSZcNSa50OqNYOLg4+gaCsJyaWyyZ1xjJ+KWPj9jYwbAHEzU7sHK97AYLSQADwnmfJYTba6Z8ixQoKWXnhzu119PTP8R6F2S27hRicjG1ZcwtdIm7SCIaAA1oAcNTquZqdLbZBOTWzz/PNncWrob4Yy35YwyV7Y7bMpSPEYG8hjR5rKML7Oc/gWY6auMOOySijz/tD9odaqCykcrd+WRPU/EfZWatFCLzLd+py9V2jVHw0rPq/wAEHr1XOMuMn+aK6kcSUnJ5ZYApMRKElEICAIAgCAIAgCAEoAgCAICpQCUJLs5iJMagTaeijCzknieMEy+zWo0V3udE5MjLDjJ+i5vaimqlweZf7Oa73foiM7bxTqmIqOc4nxmJO4GLeiv1RxBL0KdtkpyzJ5NAlbDWEICAIAgCAIAgCAIAgCAICo/0hJRCAgAQFZ3ISAUB0tk1HNGZmrXT8v2RqMlwyMq3JTyjRxR8bv6j8yoSwsGLMSkgICpKElEICAIAgCAIAgCAIAgCArNoQkohAQBAEB1Oz9QB5ad4+X+1rsTcdjbVNRmmy/tHs51N4flIa+46iJ+hUUyysPmZaiKU8x5HIW00BAEAQBAEAQBAEAQBAEJCEABCRCAyVqDmmHCLSN8jkRZQpJ8iZRcdmY1JiZKtEtDScviEiHNcY/UGk5TyMFYxknklrBY0TYLIg7WDqDDPa8nxDXe48gDoOa2rhit+ZXblZ+k6WI7VMqiKjXDda4j1kJXOMXlm9ynw8OzOXUNJx+IEfqgEeeqsynRJbmnxLoaWMoUwJY8H9OvoVTkop+FmyEpPmjTWJmEAQBAEAQAIACgKgoSA5BkAoCrHQZieX+lDCKON+ClBlWETcSN40RhFHG9rICiEGbCsaSczwyASCQTJGgGUSDzWMm1yWTJJPmZMFiWMcTUpNqgiCHFwI5tLSL9ZHJY2QlJeGWPh9xFpc1k16bZIEgSYk6DryWbeFkgrWZDiA4OAPxCYPMSAfUJF5WcBrDwWKSDKzEODHMB8LoLrCTGl4mOSxcU2mZZeMGJZGIQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQBAEAQH/2Q==",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomePageTextField(
            wingsController: fleshController,
            quantity: "Enter flesh quantity",
          ),
          HomePageTextField(
            wingsController: legsController,
            quantity: "Enter leg quantity",
          ),
          HomePageTextField(
            wingsController: wingsController,
            quantity: "Enter wings quantity",
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Map<String, int> order = {
                "flesh": int.tryParse(fleshController.text) ?? 0,
                "legs": int.tryParse(legsController.text) ?? 0,
                "wings": int.tryParse(wingsController.text) ?? 0,
              };

              Map<String, dynamic> result = processOrder(order);

              // Navigate to the result screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => resultScreen(
                    chickensKilled: result["chickensKilled"],
                    remainingStock: result["remainingStock"],
                    totalChickensKilled: totalChickensKilled,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 153, 9, 146),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("Submit"),
          ),
        ],
      ),
    ),
  );
}

// Control 4
Widget resultScreen(
    {required int chickensKilled,
    required Map<String, int> remainingStock,
    required int totalChickensKilled}) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 210, 223, 233),
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 187, 238, 157),
      title: const Text("Order Summary"),
      centerTitle: true,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq7WLP1FbvFsFwfO-niq_Wa8cu1HHfl24stg&s")),
                Text("Chickens Killed for This Order: $chickensKilled",
                    style: const TextStyle(fontSize: 18)),
                Text("Total Chickens Killed: $totalChickensKilled",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                const Text("Remaining Stock:",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Flesh: ${remainingStock["flesh"]}",
                    style: const TextStyle(fontSize: 18)),
                Text("Legs: ${remainingStock["legs"]}",
                    style: const TextStyle(fontSize: 18)),
                Text("Wings: ${remainingStock["wings"]}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Go back to the previous screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 152, 224, 152),
                        foregroundColor: const Color.fromARGB(255, 10, 7, 7),
                      ),
                      child: const Text("Go Back"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
