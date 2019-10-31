package com.fh.shop.fileController;

import com.fh.shop.utils.FileUtil;
import com.fh.shop.utils.SystemConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequestMapping("/file")
public class FileController {

/*    @RequestMapping("/uploadImage")
    @ResponseBody
    public ServerResponse uploadImage(@RequestParam MultipartFile imageInfo, HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath(SystemConstant.UPLOAD_IMAGE_PATH);
        String uploadFileName = FileUtil.copyFile(imageInfo.getInputStream(), imageInfo.getOriginalFilename(), realPath);
        return ServerResponse.success(SystemConstant.UPLOAD_IMAGE_PATH+uploadFileName);
    }*/
}
