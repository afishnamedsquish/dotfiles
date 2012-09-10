XPTemplate priority=personal

XPTinclude
	\ _common/personal
	\ _common/inlineComplete
	\ _common/common.*

XPT view_header
$title = "`title^";
$this->setTitle($title);
$this->setHeading($title);
$html->formatErrors($data['errors']);
$html->formatMessage($session->getFlash());

XPT view_pagination
<?
$pagination_html = $html->pagination(`pagination_url_format^, $data['`page^'], $data['`total_pages^'] ? range(1, $data['`total_pages^']) ? array());
echo $pagination_html;
?>

XPT view_letter_filter
<?
$letter_filter_html = $html->pagination(`letter_filter_url_format^, $data['`first_letter^'], range('A', 'Z'), array('all' => 'All'));
echo $letter_filter_html;
?>

XPT view_search_form
<? echo $form->create(array('controller' => '`controller^', 'action' => '`search^'), '`form_id^', array(), array('method' => 'get', 'class' => 'l-condensed')); ?>
	<fieldset>
		<ul>
			<? echo $form->input('`search_field_name^', '`search_field_name^', $data['SearchCriteria']['`search_field_name^'], '`search_field_label^'); ?>
			<? echo $form->hidden('data[is_posted]', 'is_posted', 1); ?>
		</ul>
		<? echo $form->submit('`Search^'); ?>
		<?= $html->link('`clear_url^', 'Clear'); ?>
	</fieldset>
</form>

XPT view_index
<?
`:view_header:^
?>
``search form...{{^`:view_search_form:^` `search form..^`}}^
``pagination...{{^`:view_pagination:^` `pagination..^`}}^
``letter filter...{{^`:view_letter_filter:^` `letter filter..^`}}^
<? if (empty($data['`key^'])): ?>
	<p>There are no `records to view^.</p>
<? else: ?>
<table>
	<thead>
		<tr>
			<th>Name</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
<? foreach ($data['`key^'] as $`key_single^): ?>
		<tr>
			<td><?= $html->special($`key_single^['`name^']); ?></td>
			<td>
				<?= $html->link('`edit_url^' . $`key_single^['`id^'], 'Edit'); ?>
			</td>
		</tr>
<? endforeach; ?>
	</tbody>
</table>
<? endif; ?>
