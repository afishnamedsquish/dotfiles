XPTemplate priority=personal

XPTinclude
	\ _common/personal
	\ _common/inlineComplete
	\ _common/common.*

XPT view_index
<?
$title = "`title^";
$this->setTitle($title);
$this->setHeading($title);
?>
<?= $html->formatErrors($data['errors']); ?>
<?= $html->formatMessage($session->getFlash()); ?>
<? if (empty($data['`key^'])): ?>
	<p>There are no `plural^.</p>
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
