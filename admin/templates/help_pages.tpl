{{include file='main_pieces/header.tpl'}}
<script type="text/javascript" src="{{$config.static_admin.js}}/tiny_mce/jquery.tinymce.js"></script>
<script type="text/javascript">
        $(function() {
                $('textarea.tinymce').tinymce({
                        // Location of TinyMCE script
                        script_url : '{{$config.static_admin.js}}/tiny_mce/tiny_mce.js',

                        // General options
                        theme : "advanced",
                        plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

                        // Theme options
                        theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
                        theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                        theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
                        theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
                        theme_advanced_toolbar_location : "top",
                        theme_advanced_toolbar_align : "left",
                        theme_advanced_statusbar_location : "bottom",
                        theme_advanced_resizing : true,

                        // Drop lists for link/image/media/template dialogs
                        template_external_list_url : "lists/template_list.js",
                        external_link_list_url : "lists/link_list.js",
                        external_image_list_url : "lists/image_list.js",
                        media_external_list_url : "lists/media_list.js",
						
						height: 600,
						width: '100%'
                });
        });
</script>

<div id="listItems" class="pagePieces">
<h1>Help pages <input type="button" value="Add" onclick="modifyItem(0)" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Search:</strong></legend>
<form method="get">
<input type="hidden" name="page" value="{{$smarty.get.page}}" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td><strong>Expression:</strong></td>
	<td width="100%"><input type="text" name="expression" value="{{$smarty.get.expression|default:''}}" /></td>
</tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Search" /> <input type="button" value="Reset" onclick="window.location='?page={{$smarty.get.page}}'" /></td>
</tr>
</table>
</form>
</fieldset>
<div class="paginare">
Pages: {{section loop=$pagini name=pagini}} <a href="{{$linkwcp}}&pg={{$smarty.section.pagini.iteration}}"{{if $curpag==$smarty.section.pagini.iteration}} class="on"{{/if}}>{{$smarty.section.pagini.iteration}}</a>{{/section}}
</div>
<table width="100%" cellpadding="5" cellspacing="1">
<tr bgcolor="#000000" style="color:#FFF">
	<th align="center">#</th>
	<th align="left" width="100%">Name</th>
	<th align="center">Order</th>
	<th align="center">Actions</th>
</tr>
{{foreach $items as $n}}
<tr bgcolor="{{cycle values='#EEE,#CCC'}}">
	<td>{{$n.Id}}</td>
	<td><strong>{{$n.Name}}</strong></td>
	<td align="center" nowrap="nowrap">{{$n.Order}}</td>
    <td align="center"><input type="button" value="Edit" onclick="modifyItem({{$n.Id}})" /><br /><form id="form_{{$n.Id}}" method="post"><input type="hidden" name="action" value="delete" /><input type="hidden" name="Id" value="{{$n.Id}}" /><input type="button" onclick="del({{$n.Id}})" value="Delete" style="margin-top:2px; background:#900" />
</form></td>
</tr>
{{/foreach}}
</table
>
<div class="paginare">
Pages: {{section loop=$pagini name=pagini}} <a href="{{$linkwcp}}&pg={{$smarty.section.pagini.iteration}}"{{if $curpag==$smarty.section.pagini.iteration}} class="on"{{/if}}>{{$smarty.section.pagini.iteration}}</a>{{/section}}
</div>
<script>
$(document).ready(function() {
		$( ".date" ).datepicker({dateFormat:"yy-mm-dd"});
	});
</script>
<script>
function del( obj )
{
	if( confirm('Really delete?') )
	{
		obj = $('#form_'+obj);
		//$(obj).find('input[name=action]').val('delete');
		$(obj).submit();
	}
}
</script>
</div>
<div id="modifyItem0" class="pagePieces" style="display:none">
<h1>Add <input type="button" value="Cancel" onclick="showItemListing()" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Form:</strong></legend>
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="action" value="modify" />
<input type="hidden" name="Id" value="-1" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td nowrap="nowrap"><strong>Name:</strong></td>
	<td width="100%"><input type="text" name="Name" value="" /></td>
</tr>
<tr>
	<td nowrap="nowrap"><strong>Text:</strong></td>
	<td><textarea name="Content" class="tinymce"></textarea></td>
</tr>
<tr>
	<td nowrap="nowrap"><strong>Order:</strong></td>
	<td><input type="text" name="Order" value="" style="width:75px" /></td>
</tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Save" /> <input type="button" value="Cancel" onclick="showItemListing()" /></td>
</tr>
</table>
</form>
</fieldset>
</div>
{{foreach $items as $n}}
<div id="modifyItem{{$n.Id}}" class="pagePieces" style="display:none">
{{*<pre>{{$n|@print_r}}</pre>*}}
<h1>Edit <input type="button" value="Cancel" onclick="showItemListing()" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Form:</strong></legend>
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="action" value="modify" />
<input type="hidden" name="Id" value="{{$n.Id}}" />
<input type="hidden" name="Link" value="{{$n.Link}}" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td nowrap="nowrap"><strong>Name:</strong></td>
	<td width="100%"><input type="text" name="Name" value="{{$n.Name}}" /></td>
</tr>
<tr>
	<td nowrap="nowrap"><strong>Text:</strong></td>
	<td><textarea name="Content" class="tinymce">{{$n.Content}}</textarea></td>
</tr>
<tr>
	<td nowrap="nowrap"><strong>Order:</strong></td>
	<td><input type="text" name="Order" value="{{$n.Order}}" style="width:75px" /></td>
</tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Save" /> <input type="button" value="Cancel" onclick="showItemListing()" /></td>
</tr>
</table>
</form>
</fieldset>
</div>
{{/foreach}}
<script>
function addInnerItem(iId){
	$('#innerItemsHolder'+iId).append('<div class="innerItemsHolderChild">'+$($('#innerItemsHolder'+iId+'>div').get(0)).html()+'</div>');
}
function showItemListing()
{
	$('.pagePieces:visible').slideUp();
	$('#listItems').slideDown();
}
function modifyItem( iId )
{
	$('#listItems').slideUp();
	$('#modifyItem'+iId).slideDown();
}
</script>
{{include file='main_pieces/footer.tpl'}}