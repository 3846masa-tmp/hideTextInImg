%% 画像にデータを埋め込む
% 画像ファイルの選択
uiwait(msgbox('データを埋め込む元画像を選択してください。'));
[FileName, PathName, FilterIndex] = uigetfile({'*.png;*.bmp;*.gif;*.jpg;*.jpeg', '画像ファイル(*.bmp,*.png,*.gif,*.jpg,*.jpeg)'}, '元画像選択');

if FilterIndex == 0 
    disp('ファイルがありません。');
    uiwait(msgbox('ファイルが存在しません。', '', 'error'));
    return;
else

% 画像読み込み
ImgPath = fullfile(PathName, FileName);
img = imread(ImgPath);
% imshow(img);

% 埋め込みデータの選択
uiwait(msgbox('埋め込むデータを選択してください。'));
[FileName, PathName, FilterIndex] = uigetfile({'*.*', 'ファイル(*.*)'}, '埋め込みデータ選択');

if FilterIndex == 0
    disp('ファイルがありません。');
    uiwait(msgbox('ファイルが存在しません。', '', 'error'));
    return;
else

% 埋め込みデータの読み込み
FilePath = fullfile(PathName, FileName);
fileID = fopen(FilePath, 'r');
bytes = fread(fileID, inf, 'uint8=>uint8');
fclose(fileID);
bytes = transpose(bytes);

% 埋め込み可能か判定
if numel(img)/4 < numel(bytes)
    disp('埋め込みファイルが大きすぎます。');
    msgbox('埋め込みファイルが大きすぎます。', '', 'error');
    return;
else

% 埋め込み処理
% RGB各々下位2bitにデータを埋め込んでいく
seekbar = waitbar(0, '生成中...');
img2 = bitshift(bitshift(img, -2), 2);
k = 1;
for char = bytes
  for i = -6 : 2 : 0
    img2(k) = img2(k) + bitshift(bitshift(bitshift(char, i), 6), -6);
    k = k + 1;
    waitbar(k / numel(bytes));
  end
end
close(seekbar);
% imshow(img2);

% ファイル出力
imwrite(img2, [ImgPath, '.build.png']);
disp('ファイルを出力しました。');
disp([ImgPath, '.build.png']);
uiwait(msgbox(['ファイルを出力しました。', 10, ImgPath, '.build.png']));

end;
end;
end;
