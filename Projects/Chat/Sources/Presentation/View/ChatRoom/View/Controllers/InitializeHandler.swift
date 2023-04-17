import UIKit

extension ChatRoomViewController {
    func initializeSettings() {
        setData()
        setUI()
    }
}

// UI
extension ChatRoomViewController {
    
    private func setUI() {
        initHeaderButtonsSetting()
        setButtonsUI()
        
        inputTextView.setToAspectSize()
//        inputTextViewHeight.constant = getTextViewHeight()
        letterCountLabel.layer.cornerRadius = 8
        
        footerWrapperView.layoutIfNeeded()
        
        initHeaderButtonsSetting()
        contentTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        safeAreaBottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
        
        setSubView()
        setContraints()
        
        addActionTarget()
    }
    
    private func addRoomButton(key: Int) {
        let button = UIButton().then {
            $0.backgroundColor = Color.Black
            $0.tag = key
            $0.setTitle("GPT \(key)", for: .normal)
        }
        
        drawerRoomStackView.addArrangedSubview(button)
    }
    
    private func setRoomList() {
        let roomList = DataStorage.instance.getGptDataSetList()
        
        roomList.sorted {
            $0.key < $1.key
        }.forEach {
            addRoomButton(key: $0.key)
        }
    }
    
    private func setSubView() {
        view.addSubview(bodyWrapper)
        bodyWrapper.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        bodyWrapper.addSubview(contentWrapperView)
        contentWrapperView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentWrapperView.addSubview(contentTableView)
        contentTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        
        contentWrapperView.addSubview(footerWrapperView)
        footerWrapperView.snp.makeConstraints {
            $0.top.equalTo(contentTableView)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        
        contentWrapperView.addSubview(footerButtonStackView)
        footerButtonStackView.snp.makeConstraints {
            $0.bottom.equalTo(footerWrapperView.snp.top)
            $0.leading.equalToSuperview()
        }
        

        
        footerButtonStackView.addArrangedSubview(letterCountWrapperView)
        letterCountWrapperView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
        
        letterCountWrapperView.addSubview(letterCountLabel)
        letterCountLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        footerButtonStackView.addArrangedSubview(scrollToBottomButton)
        scrollToBottomButton.snp.makeConstraints {
            $0.leading.equalTo(letterCountLabel.snp.trailing)
            $0.bottom.trailing.equalToSuperview()
        }
        scrollToBottomButton.addTarget(self, action: #selector(onPressScrollToBottom), for: .touchUpInside)
        
        footerWrapperView.addSubview(addImageButton)
        addImageButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        addImageButton.addTarget(self, action: #selector(onPressAddImageButton), for: .touchUpInside)
        
        
        footerWrapperView.addSubview(inputTextViewWrapper)
        inputTextViewWrapper.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalTo(addImageButton.snp.trailing)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        inputTextViewWrapper.addSubview(inputTextView)
        inputTextViewWrapper.addSubview(messageLoadingIndicator)
        inputTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(10)
        }
        
        inputTextViewWrapper.addSubview(emojiButton)
        inputTextViewWrapper.addSubview(sendMessageButton)
        
        
        sendMessageButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(40)
        }
        
        emojiButton.snp.makeConstraints {
            $0.top.equalTo(sendMessageButton)
            $0.leading.equalTo(inputTextView)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(sendMessageButton).inset(5)
        }
        
        
        view.addSubview(contentBlurView)
        view.addSubview(drawerView)
                
        
        drawerView.addSubview(drawerRoomScrollView)
        drawerView.addSubview(deleteDataButton)
        
        drawerRoomScrollView.addSubview(drawerRoomStackView)
        setRoomList()
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            self.addImageButton.heightAnchor.constraint(equalToConstant: self.footerWrapperView.frame.height),
            self.sendMessageButton.heightAnchor.constraint(equalToConstant: self.inputTextViewWrapper.frame.height)
        ])
        
        messageLoadingIndicator.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(sendMessageButton)
        }
        
        // GPT 채팅방일 경우, 이미지 추가 버튼 숨김.
        if DataStorage.instance.isGPTRoom(roomId: roomId) {
            addImageButton.snp.remakeConstraints { make in
                make.width.equalTo(10.0)
            }
            addImageButton.isHidden = true
        }
        
        contentBlurView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        let drawerWidth = UIScreen.main.bounds.size.width * 0.7
        drawerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(-drawerWidth)
            make.width.equalTo(drawerWidth)
        }
        
        drawerRoomScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(deleteDataButton.snp.top).inset(10)
        }
        
        drawerRoomStackView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
        
        drawerRoomStackView.subviews.forEach {
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
        }
        
        deleteDataButton.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func addActionTarget() {
        addImageButton.addTarget(self, action: #selector(onPressAddImageButton), for: .touchUpInside)
        
        emojiButton.addTarget(self, action: #selector(onPressEmojiButton), for: .touchUpInside)
        
        scrollToBottomButton.addTarget(self, action: #selector(onPressScrollToBottom), for: .touchUpInside)
        
        sendMessageButton.addTarget(self, action: #selector(onPressSendMessageButton), for: .touchUpInside)
        
        deleteDataButton.addTarget(self, action: #selector(onPressDeleteDataButton), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer (
            target: self, action: #selector(onPressMenuButton)
        )
        
        contentBlurView.addGestureRecognizer(tap)
    }
    
    func hidingBar() {
        guard let tabBarController = self.tabBarController,
              let navigationController = self.navigationController
        else {
            return
        }
        
        tabBarController.tabBar.isHidden = true
        navigationController.isNavigationBarHidden = false
    }
      
    //헤더 초기화
    private func initHeaderButtonsSetting() {
        self.navigationController?.navigationBar.backgroundColor = Color.DarkerGray

        searchButton.tintColor = Color.White
        
        menuButton.tintColor = Color.White
    }
        
    private func setButtonsUI() {
        addImageButton.setTitle("", for: .normal)
        scrollToBottomButton.setTitle("", for: .normal)
        emojiButton.setTitle("", for: .normal)
        
        scrollToBottomButton.tintColor = Color.LighterBlack
    }
}


extension ChatRoomViewController {
    private func setData() {
        setRoomSetting()
        loadData()
        loadGPTData()
        registComponents()
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.prefetchDataSource = self
    }
    
    private func setRoomSetting() {
        roomId = chatRoomInfo.roomId
        
        guard let crData = DataStorage.instance.getChatRoom(roomId: roomId) else {
            fatalError("채팅방 정보 불러오기 실패")
        }
        roomData = crData
        
        self.title = roomData.roomName
        
        guard let uData = DataStorage.instance.getUser(userId: chatRoomInfo.userId) else {
            fatalError("유저 정보 불러오기 실패")
        }
        userData = uData
        
        chatViewModel.setRoomInfo(roomId: roomId, userData: uData)
    }
        
    private func registComponents() {
        addKeyboardObserver()
        recognizeHidingKeyboardGesture()
        
        self.inputTextView.delegate = self
        self.contentTableView.delegate = self
        
        ChatTableViewCell.register(tableView: contentTableView)
    }

    
    
    
    
    
    func loadData() {
//        let loadedData = DataStorage.instance.getChatData(roomId: roomId, offset: offset, limit: Constants.chatLoadLimit)
//        chatData.append(contentsOf: loadedData)
        chatViewModel.loadData()
        
        // 로딩된 데이터가 제한보다 적으면 isEndReached을 true로 하여 로딩 메소드 호출 방지
//        guard loadedData.count >= Constants.chatLoadLimit else {
//            isEndReached = true
//            return
//        }
//
//        offset += Constants.chatLoadLimit
//
//        return
    }
    
    func loadGPTData() {
        gptInfo = DataStorage.instance.getUser(userId: 0)
    }
}
