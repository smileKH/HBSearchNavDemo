//
//  HBSearchViewController.m
//  HBSearchNavDemo
//
//  Created by 胡明波 on 2020/11/23.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "HBSearchViewController.h"
#import "HBSearchHeaderTitleView.h"
#import "HBSearchHistoryWordCell.h"
#import "HBSearchHotWordCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
@interface HBSearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UIView *navView;
@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic ,strong)UIButton *cancelBtn;//取消按钮
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)NSMutableArray *historyWordsAry;//历史记录
@property (nonatomic ,strong)NSArray *hotWordsAry;//热搜
@end

@implementation HBSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //保存历史到本地
    if ([NSKeyedArchiver archiveRootObject:_historyWordsAry toFile:kSearchHistoryCachePath]) {
        NSLog(@"缓存搜索历史成功！！");
    }
}
//-(NSArray *)historyWordsAry{
//    if (!_historyWordsAry) {
//        _historyWordsAry = @[@"衣服",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣服"];
//    }
//    return _historyWordsAry;
//}
-(NSArray *)hotWordsAry{
    if (!_hotWordsAry) {
        _hotWordsAry = @[@"裤子",@"衣服",@"衣意思是酸辣粉衣意思是酸辣粉酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服",@"衣意思是酸辣粉",@"衣服衣",@"衣意思是酸辣粉",@"衣服"];
    }
    return _hotWordsAry;
}
#pragma mark ==========点击取消按钮==========
-(void)clickCancelBtn:(UIButton *)btn{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    self.historyWordsAry = [NSMutableArray array];
    _historyWordsAry = [[NSKeyedUnarchiver unarchiveObjectWithFile:kSearchHistoryCachePath] mutableCopy];
    if (_historyWordsAry == nil) _historyWordsAry = [NSMutableArray arrayWithCapacity:1];
    //添加子视图
    [self addSubViewUI];
}
#pragma mark ==========添加子视图==========
-(void)addSubViewUI{
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(NAVIBAR_HEIGHT);
    }];
    
    CGFloat btnWidth = 40;
    CGFloat searchHeight = 40;
    [self.navView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView).offset(-10);
        make.left.equalTo(self.navView).offset(15);
        make.right.equalTo(self.navView).offset(-10-15-btnWidth);
        make.height.mas_equalTo(searchHeight);
    }];
    
    [self.navView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar);
        make.left.equalTo(self.searchBar.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    [self.searchBar becomeFirstResponder];
}
#pragma mark - UICollectionView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        HBSearchHeaderTitleView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELLID([HBSearchHeaderTitleView class]) forIndexPath:indexPath];
        WEAKSELF;
        if (indexPath.section == 0) {
//            header.delBtn.hidden = NO;
            header.titleLabel.text = @"历史搜索";
            header.backgroundColor = [UIColor whiteColor];
//            [header.delBtn bk_addEventHandler:^(id sender) {
//
//                weakSelf.isDelHistory = !weakSelf.isDelHistory;
//                [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//            } forControlEvents:UIControlEventTouchUpInside];
        } else {
            header.titleLabel.text = @"大家都在搜";
//            header.delBtn.hidden = YES;
        }
        return header;
    }
    return nil;
}
#pragma mark-表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.historyWordsAry.count;
    }
    return self.hotWordsAry.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WEAKSELF;
        HBSearchHistoryWordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID([HBSearchHistoryWordCell class]) forIndexPath:indexPath];
//        cell.delBtn.hidden = !self.isDelHistory;
        NSString *text = self.historyWordsAry[indexPath.row];
        cell.titleLabel.text = text;
//        [cell.delBtn bk_addEventHandler:^(id sender) {
//
//            [weakSelf.historyWordsAry removeObject:text];
//            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//        } forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else {
        HBSearchHotWordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID([HBSearchHotWordCell class]) forIndexPath:indexPath];
        cell.titleLabel.text = self.hotWordsAry[indexPath.row];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *searchText = @"";
    if (indexPath.section == 0) {
        //热词
        searchText = self.historyWordsAry[indexPath.row];
    }else if (indexPath.section == 1) {
        //热词
        searchText = self.hotWordsAry[indexPath.row];
    }
    _searchBar.text = searchText;
    [self searchGoods];
}
- (void)searchGoods{
    NSString *search = _searchBar.text;
    if (search.length == 0) {
//        [NSObject showToastWithText:];
        //@"请输入搜索的商品名称"
        return;
    }
    
    //隐藏键盘
    [self.view endEditing:YES];
    
//    self.searchText = search.removeAllSpace;
    if (![_historyWordsAry containsObject:search]) [_historyWordsAry addObject:search];
    
//    kDefineWeakSelf;
//    [YXShoppingService searchGoodsWithName:_searchText pageNum:_page sort:_sort order:_order success:^(YXShoppingSearchGoodsListModel *obj) {
//
//        weakSelf.listModel = obj;
//        weakSelf.collectionView.hidden = YES;
//        weakSelf.tableView.hidden = NO;
//
//        if (obj.list.count == 0) {
//            //没数据
//            weakSelf.isShowEmptyView = YES;
//            weakSelf.tintImgName = @"yx_yhq_wu-ss";
//            weakSelf.tintStr = @"还没有数据哦~~";
//        }
//
//        [weakSelf.tableView reloadData];
//    } fail:^(NSString *str) {
//
//        weakSelf.collectionView.hidden = YES;
//        weakSelf.tableView.hidden = NO;
//        //没数据
//        weakSelf.isShowEmptyView = YES;
//        weakSelf.tintStr = str; //@"网络请求失败，请重试";
//        [weakSelf.tableView reloadData];
//    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *text = self.historyWordsAry[indexPath.row];
        return [HBSearchHistoryWordCell getSizeWithText:text];
    } else {
        NSString *text = self.hotWordsAry[indexPath.row];
        return [HBSearchHistoryWordCell getSizeWithText:text];
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 0);
}
#pragma mark - UISearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchGoods];
}
#pragma mark ==========getter==========
-(UIView *)navView{
    if (!_navView) {
        _navView = ({
            UIView *view = [UIView new];//初始化控件
            view.backgroundColor = [UIColor whiteColor];
            view ;
        }) ;
    }
    return _navView ;
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = ({
            UISearchBar *seBar = [[UISearchBar alloc]init];
            seBar.delegate = self;
            if (@available(iOS 13, *)) {
                seBar.searchTextField.font = [UIFont systemFontOfSize:13];
            } else {
                UITextField *textfield = [seBar valueForKey:@"_searchField"];
                textfield.font = [UIFont systemFontOfSize:13];
            }
            //默认白色搜索框,多出的背景为灰色;UIBarStyleDefault 默认 UIBarStyleBlack背景为黑色
            seBar.barStyle = UIBarStyleDefault;
            //设置搜索框整体的风格为不显示背景,默认为Prominent显示
            seBar.searchBarStyle = UISearchBarStyleDefault;
            [seBar setBackgroundImage:[UIImage new]];
            [seBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"yx_search_field_bg"] forState:UIControlStateNormal];
            seBar.placeholder = @"复制标题，搜隐藏优惠券拿返利";
            seBar;
        });
    }
    return _searchBar;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = ({
            //创建按钮
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            //设置标题
            [button setTitle:@"取消" forState:UIControlStateNormal];
            //设置字体大小
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            //设置title颜色
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            //添加点击事件
            [button addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _cancelBtn;
}
#pragma mark -Getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建 layout(此处创建的是流水布局)
        UICollectionViewLeftAlignedLayout *flowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIBAR_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor] ;
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册 item
        [_collectionView registerClass:[HBSearchHeaderTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELLID([HBSearchHeaderTitleView class])];
        [_collectionView registerClass:[HBSearchHistoryWordCell class] forCellWithReuseIdentifier:CELLID([HBSearchHistoryWordCell class])];
        [_collectionView registerClass:[HBSearchHotWordCell class] forCellWithReuseIdentifier:CELLID([HBSearchHotWordCell class])];

    }
    return _collectionView ;
}
@end
