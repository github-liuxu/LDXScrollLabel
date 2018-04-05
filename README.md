# ScrollLabel
滚动的label，跑马灯效果

self.label = [[LDXScrollLabel alloc] initWithFrame:CGRectMake(0, 100, 130, 30)];
self.label.scrollType = LDXAutoScroll;
self.label.scrollDirection = LDXFromLeft;
self.label.text = @"Hello world!dfgghhhffffsfdfdfdfdf gytytutttyrtrtte";
[self.view addSubview:self.label];

