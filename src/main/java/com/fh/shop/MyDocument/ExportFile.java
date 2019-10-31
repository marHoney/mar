package com.fh.shop.MyDocument;

import com.fh.shop.biz.user.IUserService;
import com.fh.shop.param.searchUser.UserSearch;
import com.fh.shop.po.user.User;
import com.fh.shop.utils.DateTool;
import com.fh.shop.vo.user.UserVo;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;
@Component
@RequestMapping("/exportFile")
public class ExportFile implements Serializable {
    @Resource
    private IUserService userService;


    @RequestMapping("/downloadPdf")
    public void downloadPdf(HttpServletResponse response, HttpServletRequest req, User user) {
        String realPath = req.getSession().getServletContext().getRealPath(File.separator);
        try {
            // 第一步，实例化一个document对象
            Document document = new Document();
            // 第二步，设置要到出的路径
            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + UUID.randomUUID().toString() + ".pdf");
            ServletOutputStream out = response.getOutputStream();
            // 如果是浏览器通过request请求需要在浏览器中输出则使用下面方式
            // OutputStream out = response.getOutputStream();
            // 第三步,设置字符
            BaseFont bfChinese = BaseFont.createFont("C:/windows/fonts/simsun.ttc,1", BaseFont.IDENTITY_H,
                    BaseFont.EMBEDDED);
            Font fontZH = new Font(bfChinese, 12.0F, 0);
            // 第四步，将pdf文件输出到磁盘
            PdfWriter writer = PdfWriter.getInstance(document, out);
            // 第五步，打开生成的pdf文件
            document.open();
            // 第六步,设置内容
            String title = "导出用户Pdf";
            document.add(new Paragraph(new Chunk(title, fontZH).setLocalDestination(title)));
            document.add(new Paragraph("\n"));
            // 创建table,注意这里的2是两列的意思,下面通过table.addCell添加的时候必须添加整行内容的所有列
            PdfPTable table = new PdfPTable(11);
            table.setWidthPercentage(100.0F);
            // 第一列是列表名
            table.setHeaderRows(1);
            table.getDefaultCell().setHorizontalAlignment(1);
            table.addCell(new Paragraph("ID", fontZH));
            table.addCell(new Paragraph("真实姓名", fontZH));
            table.addCell(new Paragraph("用户名", fontZH));
            table.addCell(new Paragraph("密码", fontZH));
            table.addCell(new Paragraph("年龄", fontZH));
            table.addCell(new Paragraph("性别", fontZH));
            table.addCell(new Paragraph("手机号", fontZH));
            table.addCell(new Paragraph("邮箱", fontZH));
            table.addCell(new Paragraph("薪水", fontZH));
            table.addCell(new Paragraph("入职时间", fontZH));
            table.addCell(new Paragraph("图片", fontZH));
            List<User> list = userService.queryUserByFile(user);
            for (int i = 0; i < list.size(); i++) {
                table.addCell(new Paragraph("" + (list.get(i).getId()), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getRealName(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getUserName(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getPassword(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getAge(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getSex()=="1"?"男":"女", fontZH));
                table.addCell(new Paragraph("" + list.get(i).getPhone(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getEmall(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getSalary(), fontZH));
                //table.addCell(new Paragraph(list.get(i).getEntryTime(), fontZH));
               // table.addCell(Image.getInstance(realPath + list.get(i).getImgUrl()));
            }
            document.add(table);
            document.add(new Paragraph("\n"));
            // 第七步，关闭document
            document.close();
            writer.close();
            System.out.println("导出pdf成功~");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

}
