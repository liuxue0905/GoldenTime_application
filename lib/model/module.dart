import 'package:flutter/material.dart';

import 'artist.dart';
import 'hits.dart';
import 'record.dart';

class Module<T> {
  final String type;

  final String header;
  final String reason;
  final String title;
  final String description;

  final String backgroundImage;
  final Color backgroundColor;
  final Color separatorColor;

  final List<T> dataList;

  Module(
      {this.type,
      this.header,
      this.reason,
      this.title,
      this.description,
      this.backgroundImage,
      this.backgroundColor,
      this.separatorColor,
      this.dataList});

  static List<Module> getModules() {
    return modules;
  }
}

List<Module> modules = [
  Module<Record>(
    type: 'recommended',
    header: 'Recommended new releases',
    reason: null,
    title: 'New Release Radio',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/f-m-m5tQ9knrY3lPJQgFFhrdeoefL3FzY2SgEQjkxPP2HlcsI1FQd9A-Yxj8_HIOqjYPhrLf=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(0, 0, 0, 1),
    separatorColor: Color.fromRGBO(255, 255, 255, 1),
    dataList: <Record>[
      Record(
          id: 1836,
          title: '一颗不变心不变心不变心不变心不变心',
          artists: [Artist(id: 148, name: '张学友友友友友友友友友友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
    ],
  ),
  Module<Record>(
    type: 'top',
    header: 'Top Albums',
    reason: 'Popular this week',
    title: 'BLAME IT ON BABY',
    description: 'Album by DaBaby • 13 songs',
    backgroundImage:
        'https://lh3.googleusercontent.com/2j1Cse4obFQSlJjVbNi9FOXNHVgE27NiVccPUCQCdgnThqihDHXboUWqYnpN3qpTFg4HBYN8HA=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(22, 17, 16, 1),
    separatorColor: Color.fromRGBO(109, 197, 131, 1),
    dataList: <Record>[
      Record(
          id: 1836,
          title: '一颗不变心心心心心心心心心',
          artists: [Artist(id: 148, name: '张学友友友友友友友友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
      Record(
          id: 1836,
          title: '一颗不变心',
          artists: [Artist(id: 148, name: '张学友')],
          songsCount: 12),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'Romantic moods',
    reason: null,
    title: 'Sweetheart Pop',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/_8EG31lZMoy4IDmwvCvDvjuapJN77vw-NBDDob5tS0i5jI0RKV0sgi-SVqeu3UjA4-HdBi3DZ7M=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(81, 34, 87, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'Feel-good favorites',
    reason: null,
    title: 'Cloud Nine R&B',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/WwnaSyZar1s7gJWNsjWf-xmaLDDKpSs4i4bkbMtWGqFj24m-ucOwj3ltVjVy6NUsy5fTprCY=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(93, 206, 214, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'All the feelings',
    reason: null,
    title: 'All-Night Goth Pop',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/jSui6tIhAbLrf4Bl5BAUzjMpxAChWAGU5WeS_0LLOgevP8XJvH8vbqfuBaVlVyrp-AylAKtn=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(57, 34, 145, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'Throwback jams',
    reason: null,
    title: '\'00s Biggest Hits',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/3rSsn09XlksGOUhWrgB7vSJwPWzmlS0Zp7FZZ1o1cipRdFyJ_mQ0bbXg6KKeNaebF1OiXZKz=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(198, 251, 229, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'Mellow moods',
    reason: null,
    title: 'Acoustic Campfire',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/kkSI0jxnAYZ6_3jeLT7aZ9A9ITBaA5MQjGNS1jmhtdSCorKCgouBuUXg1Yvktfb_l6wflXDiFWI=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(84, 33, 95, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
  Module<Hits>(
    type: 'hits',
    header: 'Today\'s biggest hits',
    reason: null,
    title: 'Teen Pop Today',
    description: null,
    backgroundImage:
        'https://lh3.googleusercontent.com/1aN6mX4KtTKKOBfGwSftr-hxuHhHIUyxPoN7R1fEZYwZ02GrVCONCTQxtbLWxF85rUs49HCMaQ=w700-h560-n-e100-rwu-v1',
    backgroundColor: Color.fromRGBO(83, 30, 101, 1),
    dataList: [
      Hits(
          title: 'Lofi Flow State',
          description: 'Find your late night study flow.',
          image:
              'https://lh3.googleusercontent.com/SZByFf0Avu2l8FH_ycLq59kzHRkO_reiJBLJIQ5MD5YYtz2OEnqTQkh5=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Jazz Focus',
          description: 'Let these cerebral jazz tunes get your brain whirring.',
          image:
              'https://lh3.googleusercontent.com/qLWT7Juw073b-cF-Wr3Gsin40FS_CEFMP_5jz2cxgeZKuXUwlFwQzNUyTw=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Classic Rock Instrumentals',
          description:
              'Get into a groove with this steep stack of killer classic rock instrumentals.',
          image:
              'https://lh3.googleusercontent.com/8LWHO7RPMyDhXIJCPG31ZiHzkgSK4WXTI9WR-0E6e0jmFN_T9UqKJdTy70o=w700-h140-p-e100-rwu-v1'),
      Hits(
          title: 'Epic Film Scores',
          description:
              'Listen to the most epic film scores and trailer cues in modern cinema. ',
          image:
              'https://lh3.googleusercontent.com/keojDpMpF-BEXnUQBBEIzeI6Ze3Se9NhhBHSn41R9I5CLaVAiWmVw2do=w700-h140-p-e100-rwu-v1'),
    ],
  ),
];
