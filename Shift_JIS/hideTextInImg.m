%% �摜�Ƀf�[�^�𖄂ߍ���
% �摜�t�@�C���̑I��
uiwait(msgbox('�f�[�^�𖄂ߍ��ތ��摜��I�����Ă��������B'));
[FileName, PathName, FilterIndex] = uigetfile({'*.png;*.bmp;*.gif;*.jpg;*.jpeg', '�摜�t�@�C��(*.bmp,*.png,*.gif,*.jpg,*.jpeg)'}, '���摜�I��');

if FilterIndex == 0 
    disp('�t�@�C��������܂���B');
    uiwait(msgbox('�t�@�C�������݂��܂���B', '', 'error'));
    return;
else

% �摜�ǂݍ���
ImgPath = fullfile(PathName, FileName);
img = imread(ImgPath);
% imshow(img);

% ���ߍ��݃f�[�^�̑I��
uiwait(msgbox('���ߍ��ރf�[�^��I�����Ă��������B'));
[FileName, PathName, FilterIndex] = uigetfile({'*.*', '�t�@�C��(*.*)'}, '���ߍ��݃f�[�^�I��');

if FilterIndex == 0
    disp('�t�@�C��������܂���B');
    uiwait(msgbox('�t�@�C�������݂��܂���B', '', 'error'));
    return;
else

% ���ߍ��݃f�[�^�̓ǂݍ���
FilePath = fullfile(PathName, FileName);
fileID = fopen(FilePath, 'r');
bytes = fread(fileID, inf, 'uint8=>uint8');
fclose(fileID);
bytes = transpose(bytes);

% ���ߍ��݉\������
if numel(img)/4 < numel(bytes)
    disp('���ߍ��݃t�@�C�����傫�����܂��B');
    msgbox('���ߍ��݃t�@�C�����傫�����܂��B', '', 'error');
    return;
else

% ���ߍ��ݏ���
% RGB�e�X����2bit�Ƀf�[�^�𖄂ߍ���ł���
seekbar = waitbar(0, '������...');
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

% �t�@�C���o��
imwrite(img2, [ImgPath, '.build.png']);
disp('�t�@�C�����o�͂��܂����B');
disp([ImgPath, '.build.png']);
uiwait(msgbox(['�t�@�C�����o�͂��܂����B', 10, ImgPath, '.build.png']));

end;
end;
end;